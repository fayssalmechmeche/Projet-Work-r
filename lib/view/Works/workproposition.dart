import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/view/ListDevis/adddevis.dart';
import 'package:my_app/view/Works/listworkartisan.dart';
import 'package:my_app/view/Works/workfollow.dart';
import 'package:provider/provider.dart';

import '../../Controller/Particulier/ParticulierController.dart';
import '../../Controller/global.dart';

class WorkProposition extends StatefulWidget {
  const WorkProposition({Key? key}) : super(key: key);
  static const tag = "/WorkProposition";

  @override
  State<WorkProposition> createState() => _WorkPropositionState();
}

class _WorkPropositionState extends State<WorkProposition> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    var globalData = Provider.of<GlobalData>(context);
    final checkDevis = ArtisanController.checkDevisExists(
        globalData.getId(), int.parse(data['particulierID']), data['id']);
    //print(data);
    final particulier = ParticulierController.getParticulierById(
        int.parse(data['particulierID']));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              data["name"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 25),
              height: 600,
              child: ListView(shrinkWrap: true, children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Nom du client",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          FutureBuilder(
                              future: particulier,
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  //print(snapshot.data['results']);
                                  if (snapshot.data['results'] != null) {
                                    print(snapshot.data);
                                    return Container(
                                        width: 230,
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                            snapshot.data['results'][0]
                                                    ['lastname'] +
                                                ' ' +
                                                snapshot.data['results'][0]
                                                    ['name'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey)));
                                  } else {
                                    return Container(
                                        width: 230,
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(" "));
                                  }
                                } else {
                                  return Container(
                                      width: 230,
                                      padding: EdgeInsets.only(top: 5),
                                      child: Text(""));
                                }
                              }),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 30, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Catégorie",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            data["category"],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 30, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Type de logement",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            data["type"],
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 30, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Reçu le : ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            data["date"].toString().substring(0, 10),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              data["description"],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 30, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Budget",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            data["budget"],
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ])),
          FutureBuilder(
              future: checkDevis,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == true) {
                    return SizedBox();
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(
                                top: 15, right: 15, bottom: 40, left: 15),
                            width: 160,
                            height: 85,
                            child: OutlinedButton(
                              onPressed: () {
                                var response = ArtisanController.refuseChantier(
                                    globalData.getId(), data["id"]);

                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  foregroundColor: Colors.green,
                                  backgroundColor: Colors.red.withOpacity(0.75),
                                  side: const BorderSide(color: Colors.red)),
                              child: Text('Refuser',
                                  style: TextStyle(color: Colors.white)),
                            )),
                        Container(
                            padding: const EdgeInsets.only(
                                top: 15, bottom: 40, right: 15, left: 15),
                            width: 160,
                            height: 85,
                            child: OutlinedButton(
                              onPressed: () async {
                                bool checkDevis =
                                    await ArtisanController.checkDevisExists(
                                        globalData.getId(),
                                        int.parse(data['particulierID']),
                                        data['id']);

                                print(checkDevis);
                                if (checkDevis == false) {
                                  Navigator.of(context)
                                      .pushNamed(AddDevis.tag, arguments: data);
                                } else {
                                  const snackBar = SnackBar(
                                    content: Text('Devis déjà envoyé'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  foregroundColor: Colors.green,
                                  backgroundColor:
                                      Colors.green.withOpacity(0.75),
                                  side: const BorderSide(color: Colors.green)),
                              child: const Text('Accepter',
                                  style: TextStyle(color: Colors.white)),
                            ))
                      ],
                    );
                  }
                } else {
                  return SizedBox();
                }
              })
        ],
      ),
    );
  }

  Widget Picture(int index) {
    return GestureDetector(
      onTap: () {
        const snackBar = SnackBar(
          content: Text('Agrandi la photo'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 5, top: 10),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          border: Border.all(
            style: BorderStyle.solid,
            color: Colors.black,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(100),
          image: const DecorationImage(
            image: AssetImage("assets/ouvrier.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
