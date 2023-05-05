import 'package:flutter/material.dart';
import 'package:my_app/view/Task/listtasks.dart';

class WorkFollow extends StatefulWidget {
  const WorkFollow({Key? key}) : super(key: key);
  static const tag = "/WorkFollow";
  @override
  State<WorkFollow> createState() => _WorkFollowState();
}

class _WorkFollowState extends State<WorkFollow> {
  @override
  Widget build(BuildContext context) {
    var _progressValue = 0.3;
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
                        //<-- 3. SEE HERE
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
                              child: Text('Avancement')),
                          Container(
                              padding: const EdgeInsets.only(top: 10),
                              width: 250,
                              height: 25,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.grey,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.yellow),
                                    value: _progressValue,
                                  ))),
                          Text('${(_progressValue * 100).round()}%'),
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
                    //<-- 3. SEE HERE
                    side: const BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 25),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 225,
                              padding: const EdgeInsets.all(5),
                              child: Text("Récente tâche",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          Container(
                            width: 225,
                            padding: const EdgeInsets.only(
                                left: 5, right: 2, top: 2, bottom: 2),
                            child: Text("date de création de la tâche"),
                          ),
                          Container(
                              width: 225,
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "Description : Et hanc quidem praeter oppida multa duae civitates exornant Seleucia opus Seleuci regis, et Claudiopolis quam deduxit coloniam Claudius Caesar. Isaura enim antehac nimium potens, olim subversa ut rebellatrix interneciva aegre vestigia claritudinis pristinae monstrat admodum pauca.",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ))
                        ]),
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
                              onTap: () {
                                const snackBar = SnackBar(
                                  content: Text(
                                      'Redirection vers la page Mon Dossier'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
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
                                                child: Text("Mon dossier",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            Center(
                                              child: Icon(Icons.file_copy),
                                            ),
                                          ]),
                                    ]),
                              ),
                            )),
                        Container(
                            width: 130,
                            height: 130,
                            child: GestureDetector(
                              onTap: () {
                                const snackBar = SnackBar(
                                  content: Text(
                                      'Redirection vers la page Discussion'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
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
            ],
          ),
        ));
  }
}
