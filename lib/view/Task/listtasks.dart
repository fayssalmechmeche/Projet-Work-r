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
    var tasks;
    // if (globalData.getRole() == 1) {
    //   taks = ParticulierController.getTaskById(globalData.getId());
    // }

    tasks = ArtisanController.getAllTaskFromWork(globalData.getIdChantier());

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
          if (globalData.getRole() == 0 && globalData.chantier['state'] == 1)
            Visibility(
              visible: true,
              child: SizedBox(
                height: 50,
                width: 350,
                child: addTask(),
              ),
            ),
          tasksList(tasks)
        ]));
  }

  Widget addTask() {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(AddTask.tag)
              .then((_) => setState(() {}));
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

  Widget tasksList(tasks) {
    return FutureBuilder(
      future: tasks,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //print(snapshot.hasData);
        if (snapshot.hasData) {
          if (snapshot.data['results'] == null) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Aucune tâche disponible")],
            ));
          }
          if (snapshot.data['results'].length != 0) {
            //print(snapshot.data['results'].length);
            return Expanded(
                child: ListView.builder(
                    itemCount: snapshot.data['results'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardTask(index, snapshot.data['results'][index]);
                    }));
          } else {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Aucune tâche disponible")],
            ));
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget CardTask(int index, data) {
    //print(data['category']);
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Task.tag, arguments: data)
            .then((_) => setState(() {}));
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: statusCircleColor(data["state"])),
              Container(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: 200,
                          padding: const EdgeInsets.all(5),
                          child: Text(data['name'],
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold))),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.only(
                            left: 5, right: 2, top: 2, bottom: 2),
                        child: Text(data['type']),
                      ),
                      Container(
                        width: 200,
                        padding: const EdgeInsets.all(5),
                        child: statusCard(data["state"]),
                      )
                    ]),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 70),
                  height: 50,
                  width: 50,
                  child: const Icon(Icons.arrow_forward_ios))
            ],
          )),
    );
  }

  //affichage du status du projet dans le liste
  Widget statusCard(data) {
    if (data == 0) {
      return const Text('En cours');
    } else {
      return const Text('Terminé');
    }
  }

  Widget statusCircleColor(data) {
    if (data == 0) {
      return Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          color: Colors.orange,
          shape: BoxShape.circle,
        ),
      );
    } else {
      return Container(
        width: 20.0,
        height: 20.0,
        decoration: const BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
      );
    }
  }
}
