import 'package:flutter/material.dart';
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

    final chantiers = ParticulierController.getChantierById(globalData.getId());
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
          chantiersList(chantiers)
        ]));
  }

  Widget chantiersList(chantiers) {
    return FutureBuilder(
      future: chantiers,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Expanded(
              child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardChat(index);
                  }));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget CardChat(int index) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(DevisFollow.tag);
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
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: const BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("Nom du Devis",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold))),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 5, right: 2, top: 2, bottom: 2),
                            child: Text("Plomberie")),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("reçu le 10/12/2022"))
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
}
