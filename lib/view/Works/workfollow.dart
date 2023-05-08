import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/Controller/pdfAPI.dart';
import 'package:my_app/view/ListDevis/pdfdevis.dart';
import 'package:my_app/view/Task/listtasks.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';

class WorkFollow extends StatefulWidget {
  const WorkFollow({Key? key}) : super(key: key);
  static const tag = "/WorkFollow";
  @override
  State<WorkFollow> createState() => _WorkFollowState();
}

class _WorkFollowState extends State<WorkFollow> {
  @override
  Widget build(BuildContext context) {
    Future<double> getProgressedValue() async {
      var globalData = Provider.of<GlobalData>(context);
      var chantiers = await ArtisanController.getAllTaskFromWork(
          globalData.getIdChantier());
      var chantiersDone = await ArtisanController.getAllTaskDoneFromWork(
          globalData.getIdChantier());

      double _progressValue =
          chantiersDone["results"].length / chantiers["results"].length;

      return _progressValue;
    }

    Future<String> getDevis() async {
      var globalData = Provider.of<GlobalData>(context);
      final devis = await ParticulierController.getActifDevisByWork(
          globalData.getIdChantier());
      return devis["results"][0]["pdf"];
    }

    Future<Map<String, dynamic>> getLastTask() async {
      var globalData = Provider.of<GlobalData>(context);

      var lastTask =
          await ArtisanController.getLastTaskDone(globalData.getIdChantier());

      var result = lastTask["results"][0];

      return result;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(color: Colors.black),
          title: const Text(
            "Mon suivi de chantier",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 45,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 100),
                    width: 300,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 0,
                      child: Column(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text('Avancement'),
                          ),
                          FutureBuilder<double>(
                            future: getProgressedValue(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                // Le Future est en cours de chargement, vous pouvez afficher un indicateur de chargement ici si nécessaire.
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                // Une erreur s'est produite lors du chargement du Future, vous pouvez afficher un message d'erreur ici si nécessaire.
                                return Text('Erreur: ${snapshot.error}');
                              } else {
                                // Le Future s'est terminé avec succès, vous pouvez accéder à la valeur dans snapshot.data.
                                double _progressValue = snapshot.data!;
                                return Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  width: 250,
                                  height: 25,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: LinearProgressIndicator(
                                      backgroundColor: Colors.grey,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.yellow),
                                      value: _progressValue,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          FutureBuilder<double>(
                            future: getProgressedValue(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              } else if (snapshot.hasError) {
                                return Text('Erreur: ${snapshot.error}');
                              } else {
                                double _progressValue = snapshot.data!;
                                return Text(
                                    '${(_progressValue * 100).round()}%');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 300,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 0,
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: getLastTask(),
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // La future est en cours de chargement, vous pouvez afficher un indicateur de chargement ici
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        // Une erreur s'est produite pendant le chargement de la future, vous pouvez afficher un message d'erreur ici
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                              'Une erreur s\'est produite : ${snapshot.error}'),
                        );
                      } else {
                        // La future s'est terminée avec succès, vous pouvez afficher les données ici
                        final data = snapshot.data!;

                        return Container(
                          padding: const EdgeInsets.only(left: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 225,
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Récente tâche",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: 225,
                                padding: const EdgeInsets.only(
                                    left: 5, right: 2, top: 2, bottom: 2),
                                child: Text(
                                  "Date de création de la tâche : ${data['start_at']}",
                                ),
                              ),
                              Container(
                                width: 225,
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "Description : ${data['description']}",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 300,
                height: 130,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ListTasks.tag);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      //<-- 3. SEE HERE
                      side: const BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Text("Mes travaux",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))),
                                Center(
                                  child: Icon(Icons.construction),
                                ),
                              ]),
                        ]),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          width: 130,
                          height: 130,
                          child: GestureDetector(
                            onTap: () async {
                              const snackBar = SnackBar(
                                content: Text(
                                    'Redirection vers la page Mon Dossier'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              elevation: 0,
                              child: FutureBuilder<String>(
                                future: getDevis(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Erreur: ${snapshot.error}'),
                                    );
                                  } else {
                                    final pdf = snapshot.data!;
                                    return GestureDetector(
                                      onTap: () async {
                                        final url = "pdf/$pdf.pdf";
                                        final file =
                                            await pdfAPI.loadFirebase(url);
                                        if (file == null) return;
                                        openPDF(context, file);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text(
                                                  "Mon dossier",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Center(
                                                child: Icon(Icons.file_copy),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                            width: 130,
                            height: 130,
                            child: GestureDetector(
                              onTap: () async {},
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  //<-- 3. SEE HERE
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                elevation: 0,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Text("Discussion",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            Center(
                                              child: Icon(Icons.message),
                                            ),
                                          ]),
                                    ]),
                              ),
                            ))
                      ])),
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
