import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Note/NoteController.dart';
import 'package:my_app/view/ListDevis/ListProduction.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';
import '../Login/SelectionPage.dart';
import '../LunchPage/firstpage.dart';
import '../Works/listworkartisan.dart';

class HomePageArt extends StatefulWidget {
  const HomePageArt({super.key});
  static const tag = "/HomePageArt";
  @override
  State<HomePageArt> createState() => _HomePageArtState();
}

class _HomePageArtState extends State<HomePageArt> {
  var totalWorkInProgress;
  var totalWorkDone;
  var totalWorkCount;
  var totalDevisAcceptedCount;
  var totalDevisRefusedCount;

  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    final workInProgress =
        ArtisanController.getWorkByStatus(1, globalData.getId());
    final workDone = ArtisanController.getWorkByStatus(2, globalData.getId());

    final devisAccepted =
        ArtisanController.getAllDevisByStatus(3, globalData.getId());

    final devisRefused =
        ArtisanController.getAllDevisByStatus(2, globalData.getId());

    final allNote = NoteController.getNoteByArtisan(globalData.getId());

    Future<int> getTotalWorkCount() async {
      final workInProgressResult = await workInProgress;
      final workInDoneResult = await workDone;

      final workInProgressCount = workInProgressResult['results'].length;
      final workInDoneCount = workInDoneResult['results'].length;

      return workInProgressCount + workInDoneCount;
    }

    Future<int> getTotalWorkInProgressCount() async {
      final workInProgressResult = await workInProgress;
      final workInProgressCount = workInProgressResult['results'].length;

      return workInProgressCount;
    }

    Future<int> getTotalWorkDoneCount() async {
      final workInDoneResult = await workDone;
      final workInDoneCount = workInDoneResult['results'].length;

      return workInDoneCount;
    }

    Future<int> getTotalDevisAcceptedCount() async {
      final devisAcceptedResult = await devisAccepted;
      final devisAcceptedCount = devisAcceptedResult['results'].length;

      return devisAcceptedCount;
    }

    Future<int> getTotalDevisRefusedCount() async {
      final devisRefusedResult = await devisRefused;
      final devisRefusedCount = devisRefusedResult['results'].length;

      return devisRefusedCount;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const FirstPage(
                  title: '',
                );
              }), (r) {
                return false;
              });
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
          title: const Text(
            "Home",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 35,
          elevation: 0,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.only(top: 20),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.5),
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.black)),
                  child: IconButton(
                    icon: const Icon(Icons.home_repair_service_sharp, size: 20),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ListWorkArtisan.tag)
                          .then((_) => setState(() {}));
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.yellow.withOpacity(0.5),
                      shape: BoxShape.circle,
                      border: Border.all(width: 1, color: Colors.black)),
                  child: IconButton(
                    icon: const Icon(Icons.insert_drive_file, size: 20),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(ListProposition.tag)
                          .then((_) => setState(() {}));
                    },
                  ),
                ),
              ])),
          Container(
              padding: const EdgeInsets.only(top: 20),
              width: 330,
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
                  color: Colors.yellow.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 85,
                          child: Column(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text('Nombre de clients',
                                      style: TextStyle(fontSize: 18))),
                              FutureBuilder(
                                  future: getTotalWorkCount(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        final totalWorkCount = snapshot.data;

                                        return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                                totalWorkCount.toString(),
                                                style: const TextStyle(
                                                    fontSize: 28)));
                                      } else if (snapshot.hasError) {
                                        return const Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text('Erreur de chargement',
                                                style:
                                                    TextStyle(fontSize: 15)));
                                      } else {
                                        return const Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text('Erreur de chargement',
                                                style:
                                                    TextStyle(fontSize: 15)));
                                      }
                                    } else {
                                      return const CircularProgressIndicator(); // or any other widget to show progress
                                    }
                                  })
                            ],
                          ))
                    ],
                  ))),
          Container(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Card(
                        shape: RoundedRectangleBorder(
                          //<-- 3. SEE HERE
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0,
                        color: Colors.yellow.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 165,
                                height: 145,
                                child: Column(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text('Chantiers en cours',
                                            style: TextStyle(fontSize: 15))),
                                    FutureBuilder(
                                        future: getTotalWorkInProgressCount(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasData) {
                                              final totalWorkInProgress =
                                                  snapshot.data;

                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: Text(
                                                      totalWorkInProgress
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 38)));
                                            } else if (snapshot.hasError) {
                                              return const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30),
                                                  child: Text('?',
                                                      style: TextStyle(
                                                          fontSize: 15)));
                                            } else {
                                              return const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30),
                                                  child: Text('?',
                                                      style: TextStyle(
                                                          fontSize: 15)));
                                            }
                                          } else {
                                            return const CircularProgressIndicator(); // or any other widget to show progress
                                          }
                                        })
                                  ],
                                ))
                          ],
                        )),
                    Card(
                        shape: RoundedRectangleBorder(
                          //<-- 3. SEE HERE
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0,
                        color: Colors.yellow.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 165,
                                height: 145,
                                child: Column(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text('Chantiers terminés',
                                            style: TextStyle(fontSize: 15))),
                                    FutureBuilder(
                                        future: getTotalWorkDoneCount(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasData) {
                                              final totalWorkDone =
                                                  snapshot.data;

                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: Text(
                                                      totalWorkDone.toString(),
                                                      style: const TextStyle(
                                                          fontSize: 38)));
                                            } else if (snapshot.hasError) {
                                              return const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30),
                                                  child: Text('?',
                                                      style: TextStyle(
                                                          fontSize: 15)));
                                            } else {
                                              return const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30),
                                                  child: Text('?',
                                                      style: TextStyle(
                                                          fontSize: 15)));
                                            }
                                          } else {
                                            return const CircularProgressIndicator(); // or any other widget to show progress
                                          }
                                        })
                                  ],
                                ))
                          ],
                        )),
                  ]),
                  Column(children: [
                    Card(
                        shape: RoundedRectangleBorder(
                          //<-- 3. SEE HERE
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0,
                        color: Colors.yellow.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 165,
                                height: 145,
                                child: Column(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text(' Devis acceptés  ',
                                            style: TextStyle(fontSize: 15))),
                                    FutureBuilder(
                                        future: getTotalDevisAcceptedCount(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasData) {
                                              final totalDevisAcceptedCount =
                                                  snapshot.data;

                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: Text(
                                                      totalDevisAcceptedCount
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 38)));
                                            } else if (snapshot.hasError) {
                                              return const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30),
                                                  child: Text('?',
                                                      style: TextStyle(
                                                          fontSize: 15)));
                                            } else {
                                              return const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30),
                                                  child: Text('?',
                                                      style: TextStyle(
                                                          fontSize: 15)));
                                            }
                                          } else {
                                            return const CircularProgressIndicator(); // or any other widget to show progress
                                          }
                                        })
                                  ],
                                ))
                          ],
                        )),
                    Card(
                        shape: RoundedRectangleBorder(
                          //<-- 3. SEE HERE
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 0,
                        color: Colors.yellow.withOpacity(0.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                width: 165,
                                height: 145,
                                child: Column(
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(top: 15),
                                        child: Text(' Devis refusés  ',
                                            style: TextStyle(fontSize: 15))),
                                    FutureBuilder(
                                        future: getTotalDevisRefusedCount(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasData) {
                                              final totalDevisRefusedCount =
                                                  snapshot.data;

                                              return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: Text(
                                                      totalDevisRefusedCount
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 38)));
                                            } else if (snapshot.hasError) {
                                              return const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30),
                                                  child: Text('?',
                                                      style: TextStyle(
                                                          fontSize: 15)));
                                            } else {
                                              return const Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 30),
                                                  child: Text('?',
                                                      style: TextStyle(
                                                          fontSize: 15)));
                                            }
                                          } else {
                                            return const CircularProgressIndicator(); // or any other widget to show progress
                                          }
                                        })
                                  ],
                                ))
                          ],
                        ))
                  ]),
                ],
              )),
          Container(
              padding: const EdgeInsets.only(top: 20),
              width: 330,
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
                  color: Colors.yellow.withOpacity(0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          height: 105,
                          child: Column(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text('Ma note',
                                      style: TextStyle(fontSize: 18))),
                              FutureBuilder(
                                  future: allNote,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        var results = snapshot.data?['results'];
                                        late double note;

                                        print(results);
                                        if (results != null &&
                                            results.isNotEmpty) {
                                          double total = 0;
                                          results.forEach((item) {
                                            total = total + item['note'];
                                          });
                                          note = total / results.length;
                                        } else {
                                          note = 0;
                                        }

                                        return Column(
                                          children: [
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: RatingOfProfile(note)),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text('${note} / 5',
                                                    style: TextStyle(
                                                        fontSize: 20)))
                                          ],
                                        );
                                      } else if (snapshot.hasError) {
                                        return const Padding(
                                            padding: EdgeInsets.only(top: 30),
                                            child: Text('?',
                                                style:
                                                    TextStyle(fontSize: 15)));
                                      } else {
                                        return const Padding(
                                            padding: EdgeInsets.only(top: 30),
                                            child: Text('?',
                                                style:
                                                    TextStyle(fontSize: 15)));
                                      }
                                    } else {
                                      return const CircularProgressIndicator(); // or any other widget to show progress
                                    }
                                  })
                            ],
                          ))
                    ],
                  )))
        ]));
  }

  Widget RatingOfProfile(double rating) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      DecoratedIcon(
        icon: Icon(
          rating > 0 && rating < 1 ? Icons.star_half : Icons.star,
          color: rating > 0 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration: const IconDecoration(
            border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 1.0 && rating < 2.0 ? Icons.star_half : Icons.star,
          color: rating > 1 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration: const IconDecoration(
            border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 2.0 && rating < 3.0 ? Icons.star_half : Icons.star,
          color: rating > 2 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration: const IconDecoration(
            border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 3.0 && rating < 4.0 ? Icons.star_half : Icons.star,
          color: rating > 3 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration: const IconDecoration(
            border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 4.0 && rating < 5.0 ? Icons.star_half : Icons.star,
          color: rating > 4 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration: const IconDecoration(
            border: IconBorder(color: Colors.black, width: 2)),
      ),
    ]);
  }
}
