import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_app/view/Task/taskedit.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';

class Task extends StatefulWidget {
  const Task({super.key});
  static const tag = "/Task";
  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(children: [
        const Center(
          child: Text(
            "Nom de la tâche",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 30),
          height: 600,
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: const Text(
                            "Categorie",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "Plomberie",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: const Text(
                            "Date prévisionnelle de début",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "01/01/2000",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: const Text(
                            "Date réelle de début",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "01/01/2000",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: const Text(
                            "Date prévisionnelle de fin",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "01/01/2000",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: const Text(
                            "Date réelle de fin",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "01/01/2000",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: const Text(
                            "Description",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          width: 300,
                          child: const Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: const Text(
                            "Budget prévisionnel",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "1500",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          child: const Text(
                            "Budget réalisé",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text(
                            "1470",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        if (globalData.getRole() == 0)
          Container(
              padding: const EdgeInsets.only(top: 20),
              width: 120,
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(TaskEdit.tag);
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green)),
                child: const Text('Modifier',
                    style: TextStyle(color: Colors.black)),
              )),
      ]),
    );
  }
}
