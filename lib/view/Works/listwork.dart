import 'package:flutter/material.dart';
import 'package:my_app/view/Works/workfollow.dart';
import 'package:provider/provider.dart';
import '../../Controller/Artisan/ArtisanController.dart';
import '../../Controller/Particulier/ParticulierController.dart';
import '../../Controller/global.dart';
import 'addwork.dart';

class ListWork extends StatefulWidget {
  const ListWork({Key? key}) : super(key: key);

  @override
  State<ListWork> createState() => _ListWorkState();
}

class _ListWorkState extends State<ListWork> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    var chantiers;
    if (globalData.getRole() == 1) {
      chantiers = ParticulierController.getChantierById(globalData.getId());
    }
    if (globalData.getRole() == 0) {
      chantiers = ArtisanController.getChantierById(globalData.getId());
    }

    //print(chantiers.toString());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
          title: const Text(
            "Mes chantiers",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 45,
          elevation: 0,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (globalData.getRole() == 1)
            Visibility(
              visible: true,
              child: SizedBox(
                height: 50,
                width: 350,
                child: addWork(),
              ),
            ),
          chantiersList(chantiers)
        ]));
  }

  Widget addWork() {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AddWork.tag)
              .then((_) => setState(() {}));
          const snackBar = SnackBar(
            content: Text('Works page have been lunched'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Card(
            shape: const StadiumBorder(
              //<-- 3. SEE HERE
              side: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            elevation: 10,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 45),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("Créer un nouveau chantier"))
                      ]),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 70),
                    height: 50,
                    width: 50,
                    child: const Icon(Icons.add))
              ],
            )));
  }

  Widget chantiersList(chantiers) {
    return FutureBuilder(
      future: chantiers,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //print(snapshot.hasData);
        if (snapshot.hasData) {
          if (snapshot.data['results'] == null) {
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
                      return CardChat(index, snapshot.data['results'][index]);
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
    //print(data['category']);
    final globalData = Provider.of<GlobalData>(context);
    return GestureDetector(
        onTap: () {
          globalData.setChantier(data);

          Navigator.of(context).pushNamed(WorkFollow.tag).then((_) => setState(() {}));
        },
        child: Card(
            shape: const StadiumBorder(
              //<-- 3. SEE HERE
              side: BorderSide(
                color: Colors.black,
                width: 1.0, //index % 2 == 0 ? 1.0 : 0.0,
              ),
            ),
            elevation: 10,
            color: index % 2 == 0
                ? Colors.white
                : const Color.fromARGB(255, 190, 188,
                    188), //index % 2 == 0 ? Colors.white : Colors.grey,
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
                        Container(
                            width: 200,
                            padding: const EdgeInsets.all(5),
                            child: Text("${data['name']}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        Container(
                          width: 200,
                          padding: const EdgeInsets.only(
                              left: 5, right: 2, top: 2, bottom: 2),
                          child: Text("${data['category']}"),
                        ),
                        Container(
                            width: 200,
                            padding: const EdgeInsets.all(5),
                            child: statusCard(data))
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

  //affichage du status du projet dans le liste
  Widget statusCard(data) {
    if (data['state'] == 0) {
      return const Text('En recherche d\'un artisan');
    } else if (data['state'] == 1) {
      return const Text('En cours');
    } else {
      return const Text('Terminé');
    }
  }

  Widget statusCircleColor(data) {
    if (data['state'] == 0) {
      return Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
      );
    } else if (data['state'] == 1) {
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
