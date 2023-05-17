import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/ChantierController/ChantierController.dart';
import 'package:my_app/view/ListDevis/devis.dart';
import 'package:provider/provider.dart';
import '../../Controller/Particulier/ParticulierController.dart';
import '../../Controller/global.dart';

class ListProposition extends StatefulWidget {
  const ListProposition({Key? key}) : super(key: key);
  static const tag = "/listproposition";

  @override
  State<ListProposition> createState() => _ListPropositionState();
}

class _ListPropositionState extends State<ListProposition> {
  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> data = {'id': '1'};
    if (ModalRoute.of(context)!.settings.arguments != null) {
      data = ModalRoute.of(context)!.settings.arguments as Map;
    } else {
      data['id'] = 1;
    }
    final globalData = Provider.of<GlobalData>(context);
    var devis;

    if (globalData.getRole() == 1) {
      print('test');
      devis = ParticulierController.getDevisByWorkID(
          globalData.getId(), data['id']);
    }
    if (globalData.getRole() == 0) {
      devis = ArtisanController.getAllDevis(globalData.getId());
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          title: Text(
            "Mes propositions de devis",
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
              height: 30,
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
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Aucune proposition de devis")],
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
              children: [Text("Aucune proposition de devis")],
            ));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget CardChat(int index, data) {
    //print(data);
    final globalData = Provider.of<GlobalData>(context);
    final chantier =
        ChantierController.getChantierById(int.parse(data['workID']));
    var owner;
    if (globalData.getRole() == 1) {
      print('test');
      owner = ArtisanController.getArtisanById(int.parse(data['artisanID']));
    }
    if (globalData.getRole() == 0) {
      owner = ParticulierController.getParticulierById(
          int.parse(data['particulierID']));
    }

    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(DevisFollow.tag, arguments: data)
              .then((_) => setState(() {}));
          ;
        },
        child: Card(
            shape: StadiumBorder(
              //<-- 3. SEE HERE
              side: BorderSide(color: Colors.black, width: 1),
            ),
            elevation: 10,
            color: index % 2 == 0
                ? Colors.white
                : Color.fromARGB(255, 190, 188, 188),
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
                        FutureBuilder(
                            future: chantier,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                //print(snapshot.data['results']);
                                if (snapshot.data['results'] != null) {
                                  data['nameWork'] =
                                      snapshot.data['results'][0]['name'];
                                  //print(data);
                                  return Container(
                                      width: 230,
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                          "Chantier : " +
                                              snapshot.data['results'][0]
                                                  ['name'],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)));
                                } else {
                                  return Container(
                                      width: 230,
                                      padding: EdgeInsets.all(5),
                                      child: Text("Chantier : Erreur"));
                                }
                              } else {
                                return Container(
                                    width: 230,
                                    padding: EdgeInsets.all(5),
                                    child: Text("Chantier : Erreur"));
                              }
                            }),
                        FutureBuilder(
                            future: owner,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                //print(snapshot.data['results']);
                                if (snapshot.data['results'] != null) {
                                  print(snapshot.data);
                                  return Container(
                                      width: 230,
                                      padding: EdgeInsets.all(5),
                                      child: (globalData.getRole() == 1)
                                          ? Text(
                                              'Artisan : ' +
                                                  snapshot.data['results'][0]
                                                      ['name'] +
                                                  ' ' +
                                                  snapshot.data['results'][0]
                                                      ['lastname'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ))
                                          : Text(
                                              'Client : ' +
                                                  snapshot.data['results'][0]
                                                      ['name'] +
                                                  ' ' +
                                                  snapshot.data['results'][0]
                                                      ['lastname'],
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16,
                                              )));
                                } else {
                                  return Container(
                                      width: 230,
                                      padding: EdgeInsets.all(5),
                                      child: Text("Artisan : Erreur"));
                                }
                              } else {
                                return Container(
                                    width: 230,
                                    padding: EdgeInsets.all(5),
                                    child: Text("Artisan : Erreur"));
                              }
                            }),
                        Padding(
                            padding: EdgeInsets.all(5), child: statusCard(data))
                      ]),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 50),
                    height: 50,
                    width: 50,
                    child: const Icon(Icons.arrow_forward_ios))
              ],
            )));
  }

  Widget statusCard(data) {
    if (data['state'] == 1) {
      return const Text('Statut : En attente');
    } else if (data['state'] == 2) {
      return const Text('Statut : Proposition refusée');
    } else {
      return const Text('Statut : Proposition acceptée');
    }
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
          color: Colors.red,
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
