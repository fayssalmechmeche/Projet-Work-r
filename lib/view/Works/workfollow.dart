import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Conversation/ConversationController.dart';
import 'package:my_app/Controller/Note/NoteController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/Controller/pdfAPI.dart';
import 'package:my_app/view/ListDevis/pdfdevis.dart';
import 'package:my_app/view/Msg/chat.dart';
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
    var globalData = Provider.of<GlobalData>(context);
    Future<double> getProgressedValue() async {
      var globalData = Provider.of<GlobalData>(context);
      var chantiers = await ArtisanController.getAllTaskFromWork(
          globalData.getIdChantier());
      var chantiersDone = await ArtisanController.getAllTaskDoneFromWork(
          globalData.getIdChantier());
      double _progressValue = 0;
      if (chantiersDone["results"] != null && chantiers["results"] != null) {
        _progressValue =
            chantiersDone["results"].length / chantiers["results"].length;
        if (_progressValue.isNaN) {
          return _progressValue = 0;
        }
      }

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

    Future<void> _dialogEndChantierBuilder() {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmation de la clôturation du chantier'),
            content: const Text(
              "Souhaitez-vous bien mettre fin à ce chantier et accepter ainsi qu'il soit traité comme un chantier terminé ?",
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child:
                    const Text('Refuser', style: TextStyle(color: Colors.red)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text(
                  'Accepter',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () async {
                  await ArtisanController.endChantier(globalData.chantier['id'],
                      int.parse(globalData.getPartiuclierIdChantier()));
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _dialogNoteBuilder() async {
      bool noteExists = await NoteController.checkNoteExists(
          int.parse(globalData.getArtisanIdChantier()),
          globalData.getId(),
          globalData.getIdChantier());

      var _currentValue;

      if (noteExists == false) {
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            String? _dropdownvalue;
            List<String> category = ['0', '1', '2', '3', '4', '5'];
            return AlertDialog(
              title: const Text('Notez votre artisan !'),
              content: Container(
                padding: const EdgeInsets.only(top: 20),
                width: 330,
                child: DropdownButtonFormField<String?>(
                  hint: const Text('Sélectionnez une note de 0 à 5'),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(2),
                  ),
                  items: category.map((value) {
                    return DropdownMenuItem<String>(
                        child: Text(value), value: value);
                  }).toList(),
                  value: _dropdownvalue,
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropdownvalue = newValue;
                    });
                  },
                ),
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text('Annuler',
                      style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  child: const Text(
                    'Ajouter',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () async {
                    await NoteController.addNotetoArtisan(
                        int.parse(globalData.getArtisanIdChantier()),
                        globalData.getId(),
                        int.parse(_dropdownvalue!),
                        globalData.getIdChantier());

                    const snackBar = SnackBar(
                      content: Text('Note ajoutée avec succès !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        var note = await NoteController.getOneNoteByArtisan(
            int.parse(globalData.getArtisanIdChantier()),
            globalData.getId(),
            globalData.getIdChantier());

        var result = note["results"][0]["note"];
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Vous avez déjà noté cet artisan '),
              content: Container(
                padding: const EdgeInsets.only(top: 20),
                width: 330,
                child: Text(
                  "Vous avez déjà noté cet artisan, vous ne pouvez pas le noter deux fois ! \n"
                  "Voici votre note :  $result/5",
                ),
              ),
            );
          },
        );
      }
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
                                double _progressValue = 0;

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
                              } else {
                                // Le Future s'est terminé avec succès, vous pouvez accéder à la valeur dans snapshot.data.
                                double _progressValue = snapshot.data!;
                                print(_progressValue);
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
                              if (snapshot.hasData) {
                                if (snapshot.data != null) {
                                  double _progressValue = snapshot.data!;
                                  return Text(
                                      '${(_progressValue * 100).round()}%');
                                } else {
                                  double _progressValue = 0;
                                  return Text(
                                      '${(_progressValue * 100).round()}%');
                                }
                              } else if (snapshot.hasError) {
                                double _progressValue = 0;
                                return Text(
                                    '${(_progressValue * 100).round()}%');
                              } else {
                                return const Text("?");
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
                      if (snapshot.hasData) {
                        if (snapshot.data == null) {
                          //print(snapshot.data);
                          return Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Aucune proposition de chantier")],
                          ));
                        } else {
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
                                    "Tâche récente: ${data['name']}",
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
                      } else {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text("Aucune Tâche")],
                        ));
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
                    Navigator.of(context)
                        .pushNamed(ListTasks.tag)
                        .then((_) => setState(() {}));
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
                        FutureBuilder<String>(
                          future: getDevis(),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == null) {
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Aucun devis"),
                                    ],
                                  ),
                                );
                              }
                              final pdf = snapshot.data!;
                              return Container(
                                width: 130,
                                height: 130,
                                child: GestureDetector(
                                  onTap: () async {
                                    final url = "pdf/$pdf";
                                    final file = await pdfAPI.loadFirebase(url);
                                    if (file == null) return;
                                    openPDF(context, file);
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                "Mon dossier",
                                                overflow: TextOverflow.ellipsis,
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
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Container(
                                  width: 130,
                                  height: 130,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      elevation: 0,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("Aucun devis"),
                                          ],
                                        ),
                                      )));
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        Container(
                            width: 130,
                            height: 130,
                            child: GestureDetector(
                              onTap: () async {
                                var dataProfile;
                                if (globalData.getRole() == 1) {
                                  dataProfile = ArtisanController
                                      .getArtisanById(int.parse(
                                          globalData.getArtisanIdChantier()));
                                }
                                if (globalData.getRole() == 0) {
                                  dataProfile =
                                      ParticulierController.getParticulierById(
                                          int.parse(globalData
                                              .getPartiuclierIdChantier()));
                                }
                                bool conversationExists =
                                    await ConversationController
                                        .checkChantierConversationExists(
                                            globalData.getIdChantier());

                                final receiver = await dataProfile;

                                if (conversationExists) {
                                  Map<String, dynamic> arguments = {
                                    'chantier': globalData.getIdChantier(),
                                    'type': "private",
                                    'receiver': receiver['results'][0]['name'] +
                                        " " +
                                        receiver['results'][0]['lastname']
                                  };
                                  Navigator.of(context).pushNamed(Chat.tag,
                                      arguments: arguments);
                                } else {
                                  Map<String, dynamic> arguments = {
                                    'chantier': globalData.getIdChantier(),
                                    'type': "private",
                                    'receiver': receiver['results'][0]['name'] +
                                        " " +
                                        receiver['results'][0]['lastname']
                                  };
                                  await ConversationController
                                      .createChantierConversation(
                                          globalData.getIdChantier(),
                                          globalData.getArtisanIdChantier(),
                                          globalData
                                              .getPartiuclierIdChantier());
                                  Navigator.of(context).pushNamed(Chat.tag,
                                      arguments: arguments);
                                }
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
              if (globalData.getRole() == 1 &&
                  globalData.chantier['state'] == 2)
                Container(
                    padding: const EdgeInsets.only(
                        top: 60, bottom: 15, right: 15, left: 15),
                    width: 200,
                    height: 105,
                    child: OutlinedButton(
                      onPressed: () {
                        _dialogNoteBuilder();
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          foregroundColor: Colors.yellow,
                          backgroundColor: Colors.yellow.withOpacity(0.5),
                          side: const BorderSide(color: Colors.yellow)),
                      child: const Text('Noter mon artisan',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black)),
                    )),
              if (globalData.getRole() == 0 &&
                  globalData.chantier['state'] == 1)
                Container(
                    padding: const EdgeInsets.only(
                        top: 60, bottom: 15, right: 15, left: 15),
                    width: 200,
                    height: 105,
                    child: OutlinedButton(
                      onPressed: () {
                        _dialogEndChantierBuilder();
                      },
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.red.withOpacity(0.5),
                          side: const BorderSide(color: Colors.red)),
                      child: const Text('Clôturer le chantier',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black)),
                    ))
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
