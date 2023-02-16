import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_app/view/Works/workproposition.dart';



class ListWorkArtisan extends StatefulWidget {
  const ListWorkArtisan({Key? key}) : super(key: key);
  static const tag = "/listworkartisan";

  @override
  State<ListWorkArtisan> createState() => _ListWorkArtisanState();
}

class _ListWorkArtisanState extends State<ListWorkArtisan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Propositions de chantiers",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 35,
        elevation: 0,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start, children: [ListTest()]),
    );
  }

  Widget ListTest() {
    return Expanded(
        child: SizedBox(
            height: 200.0,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: 350,
                      child: CardProposition(index),
                    ),
                  ],
                );
              },
            )));
  }

  Widget CardProposition(int index) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(WorkProposition.tag);
          const snackBar = SnackBar(
            content: Text('Propositons page have been lunched'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                      children: const [
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("Renovation de la salle de bain",
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold))),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 5, right: 2, top: 2, bottom: 2),
                            child: Text("Renovation")),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("Reçu le 16/02/2023"))
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
