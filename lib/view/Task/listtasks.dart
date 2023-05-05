import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:my_app/view/Task/task.dart';
import 'package:my_app/view/Works/workfollow.dart';
import 'package:provider/provider.dart';
import '../../Controller/Artisan/ArtisanController.dart';
import '../../Controller/Particulier/ParticulierController.dart';
import '../../Controller/global.dart';
import 'addtask.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({super.key});
  static const tag = "/ListTasks";
  @override
  State<ListTasks> createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);

    //print(chantiers.toString());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Mes tâches",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 45,
          elevation: 0,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (globalData.getRole() == 0)
            Visibility(
              visible: true,
              child: SizedBox(
                height: 50,
                width: 350,
                child: addTask(),
              ),
            ),
          tasksList()
        ]));
  }

  Widget addTask() {
    return GestureDetector(
        onTap: () {
           Navigator.of(context).pushNamed(AddTask.tag);
        },
        child: Card(
            shape: const StadiumBorder(
              //<-- 3. SEE HERE
              side: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
            elevation: 10,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 45),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("Créer une nouvelle tâche"))
                      ]),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 70),
                    height: 50,
                    width: 50,
                    child: const Icon(Icons.add))
              ],
            )));
  }

  Widget tasksList() {
    return Expanded(
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return CardTask(index);
            }));
  }

  Widget CardTask(int index) {
    //print(data['category']);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Task.tag);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          //<-- 3. SEE HERE
          side: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(50.0),
        ),
        elevation: 0,
        child:  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child:Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
      )),
                Container(
                  padding: const EdgeInsets.only(left: 25),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        Container(
                              width: 200,
                              padding: const EdgeInsets.all(5),
                              child: Text("Nom d'une tâche",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          Container(
                            width: 200,
                            padding: const EdgeInsets.only(
                                left: 5, right: 2, top: 2, bottom: 2),
                            child: Text("Plomberie"),
                          ),
                          Container(
                              width: 200,
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                "En cours",
                              ))
                      ]),
                ),
                Container(
                    padding: const EdgeInsets.only(left: 70),
                    height: 50,
                    width: 50,
                    child: const Icon(Icons.arrow_forward_ios))
              ],
            )
      ),
    );
  }

  //affichage du status du projet dans le liste
  Widget statusCard(data) {
    if (data['state'] == 0) {
      return const Text('En recherche d\'un artisan');
    } else if (data['state'] == 1) {
      return const Text('En cours');
    } else {
      return const Text('Terminé');
    }
  }

  Widget statusCircleColor(data) {
    if (data['state'] == 0) {
      return Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
      );
    } else if (data['state'] == 1) {
      return Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          color: Colors.green,
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
