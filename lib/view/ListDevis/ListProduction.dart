import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/view/ListDevis/devis.dart';
import 'package:provider/provider.dart';
import '../../Controller/Particulier/ParticulierController.dart';
import '../../Controller/global.dart';

class ListProposition extends StatefulWidget {
  const ListProposition({Key? key}) : super(key: key);
  static const tag = "/devis";

  @override
  State<ListProposition> createState() => _ListPropositionState();
}

class _ListPropositionState extends State<ListProposition> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    var devis;
    print("role");
    print(globalData.getRole());
    print(globalData.getId());
    if (globalData.getRole() == 1) {
      devis = ParticulierController.getAllDevis(globalData.getId());
      print(devis);
    }
    if (globalData.getRole() == 0) {
      print("artisan");
      devis = ArtisanController.getAllDevis(globalData.getId());
      print(devis);
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
          title: Text(
            "Mes Devis",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 45,
          elevation: 0,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Visibility(
            visible: true,
            child: SizedBox(
              height: 50,
              width: 350,
            ),
          ),
          chantiersList(devis)
        ]));
  }

  Widget chantiersList(devis) {
    return FutureBuilder(
      future: devis,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //print(snapshot.hasData);
        if (snapshot.hasData) {
          if (snapshot.data['results'] == null) {
            print(snapshot.data);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Aucune proposition de chantier")],
            ));
          }
          if (snapshot.data['results'].length != 0) {
            //print(snapshot.data['results'].length);
            return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data['results'].length,
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.data['results'][index]['state'] != 0) {
                        return CardChat(index, snapshot.data['results'][index]);
                      }
                    }));
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Aucun chantier disponible")],
            ));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget CardChat(int index, data) {
    final globalData = Provider.of<GlobalData>(context);
    return GestureDetector(
        onTap: () {
          if (globalData.getRole() == 1) {
            Navigator.of(context).pushNamed(DevisFollow.tag, arguments: data);
          }
          const snackBar = SnackBar(
            content: Text('Works page have been lunched'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Card(
            shape: StadiumBorder(
              //<-- 3. SEE HERE
              side: BorderSide(
                color: Colors.black,
                width: index % 2 == 0 ? 1.0 : 0.0,
              ),
            ),
            elevation: 10,
            color: index % 4 == 0 ? Colors.white : Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: statusCircleColor(data)),
                Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(data["type"],
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 5, right: 2, top: 2, bottom: 2),
                            child: Text(data["category"])),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(data["price"]))
                      ]),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 70),
                    height: 50,
                    width: 50,
                    child: const Icon(Icons.arrow_forward_ios))
              ],
            )));
  }

  Widget statusCircleColor(data) {
    if (data['state'] == 1) {
      return Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
      );
    } else if (data['state'] == 2) {
      return Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      );
    } else {
      return const SizedBox(
        width: 20.0,
        height: 20.0,
        child: Icon(
          Icons.check_outlined,
          color: Colors.green,
        ),
      );
    }
  }
}
