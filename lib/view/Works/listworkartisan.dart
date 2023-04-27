import 'package:flutter/material.dart';
import 'package:my_app/view/Works/workproposition.dart';
import 'package:provider/provider.dart';

import '../../Controller/Artisan/ArtisanController.dart';
import '../../Controller/global.dart';

class ListWorkArtisan extends StatefulWidget {
  const ListWorkArtisan({Key? key}) : super(key: key);
  static const tag = "/listworkartisan";

  @override
  State<ListWorkArtisan> createState() => _ListWorkArtisanState();
}

class _ListWorkArtisanState extends State<ListWorkArtisan> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    final chantiers = ArtisanController.getWorkByStatus(0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Propositions de chantiers",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 35,
        elevation: 0,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [chantiersList(chantiers)]),
    );
  }

  Widget chantiersList(chantiers) {
    return FutureBuilder(
      future: chantiers,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
       if (snapshot.hasData) {
          if (snapshot.data['results'].length != 0) {
            print(snapshot.data['results'].length);
            return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data['results'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return cardChantier(index, snapshot.data['results'][index]);
                    }));
          } else {
             return Center(child:Column(mainAxisAlignment: MainAxisAlignment.center,children: [Text("Aucune proposition de chantier")],) );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }



  Widget cardChantier(int index , data) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(WorkProposition.tag, arguments: data);
        },
        child: Card(
            shape: StadiumBorder(
              side: BorderSide(
                color: Colors.black,
                width: index % 2 == 0 ? 1.0 : 0.0,
              ),
            ),
            elevation: 10,
            color: index % 2 == 0 ? Colors.white : Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: Text("${data['name']}",
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold))),
                         Padding(
                            padding: EdgeInsets.only(
                                left: 5, right: 2, top: 2, bottom: 2),
                            child: Text("${data['category']}")),
                         Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("Reçu le ${data['date']}"))
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
