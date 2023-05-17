import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/Controller/global.dart';
import 'package:my_app/Controller/pdfAPI.dart';
import 'package:my_app/view/ListDevis/pdfdevis.dart';
import 'package:provider/provider.dart';

class DevisFollow extends StatefulWidget {
  const DevisFollow({Key? key}) : super(key: key);
  static const tag = "/DevisFollow";
  @override
  State<DevisFollow> createState() => _DevisFollowState();
}

class _DevisFollowState extends State<DevisFollow> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final globalData = Provider.of<GlobalData>(context);

    var particulierID = int.tryParse(data['particulierID']);
    var artisanID = int.tryParse(data['artisanID']);
    final particulier =
        ParticulierController.getParticulierById(particulierID!);
    final artisan = ArtisanController.getArtisanById(artisanID!);

    // final artisan = ArtisanController.getArtisan(globalData.getId());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Mon devis",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 45,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nom de l'artisan : "),
                    FutureBuilder<Map<String, dynamic>>(
                        future: artisan,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null &&
                                snapshot.data?['results'] != null) {
                              final artisan = snapshot.data!['results'][0];
                              return Text(
                                artisan['name'] + " " + artisan['lastname'],
                                style: TextStyle(color: Colors.grey),
                              );
                            } else {
                              return Text(
                                "Problème dans le chargement des données",
                                style: TextStyle(color: Colors.grey),
                              );
                            }
                          } else {
                            return Text(
                              "Problème dans le chargement des données",
                              style: TextStyle(color: Colors.grey),
                            );
                          }
                        }),
                    SizedBox(height: 20),
                    Text("Nom du particulier : "),
                    FutureBuilder<Map<String, dynamic>>(
                        future: particulier,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data != null &&
                                snapshot.data?['results'] != null) {
                              final particulier = snapshot.data!['results'][0];
                              return Text(
                                particulier['name'] +
                                    " " +
                                    particulier['lastname'],
                                style: TextStyle(color: Colors.grey),
                              );
                            } else {
                              return Text(
                                "Problème dans le chargement des données",
                                style: TextStyle(color: Colors.grey),
                              );
                            }
                          } else {
                            return Text(
                              "Problème dans le chargement des données",
                              style: TextStyle(color: Colors.grey),
                            );
                          }
                        }),
                    SizedBox(height: 20),
                    Text("Catégorie de travaux : "),
                    Text(
                      data["category"],
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    Text("Type de logement : "),
                    Text(
                      data["type"],
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    Text("Budget : "),
                    SizedBox(width: 10),
                    Text(
                      data["price"],
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    Text("Devis en PDF : "),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () async {
                        const snackBar = SnackBar(
                          content: Text('Ouverture du devis en cours...'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        final url = "pdf/${data["pdf"]}";
                        final file = await pdfAPI.loadFirebase(url);
                        if (file == null) return;
                        openPDF(context, file);
                      },
                      child: Text(
                        "Voir le devis",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Description : "),
                    SizedBox(height: 10),
                    Container(
                      height: 200,
                      child: ListView(
                        children: [
                          Text(
                            data["description"],
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    if (globalData.getRole() == 1 && data["state"] < 3)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 30, bottom: 15, right: 30, ),
                                width: 160,
                                height: 75,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    final response =
                                        await ParticulierController.refuseDevis(
                                            int.tryParse(
                                                data['particulierID'])!,
                                            data['id']);

                                    if (response["success"] == true) {
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(response["msg"]),
                                      ));
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      foregroundColor: Colors.red,
                                      side:
                                          const BorderSide(color: Colors.red)),
                                  child: const Text('Refuser',
                                      style: TextStyle(color: Colors.black)),
                                )),
                            Container(
                                padding: const EdgeInsets.only(
                                    top: 30, bottom: 15, right: 15, left: 15),
                                width: 160,
                                height: 75,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    final response = await ParticulierController
                                        .accepteDevis(
                                            int.tryParse(
                                                data['particulierID'])!,
                                            data['id'],
                                            int.tryParse(data['workID'])!,
                                            int.tryParse(data['artisanID'])!);

                                    if (response["success"] == true) {
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(response["msg"]),
                                      ));
                                    }
                                  },
                                  style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                      foregroundColor: Colors.green,
                                      side: const BorderSide(
                                          color: Colors.green)),
                                  child: const Text('Accepter',
                                      style: TextStyle(color: Colors.black)),
                                ))
                          ]),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

void openPDF(BuildContext context, File file) {
  print("openPDF");
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => PdfDevis(file: file),
    ),
  );
}
