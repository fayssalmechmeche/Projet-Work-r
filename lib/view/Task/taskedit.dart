import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/global.dart';
import 'package:my_app/view/Task/listtasks.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../Controller/Particulier/ParticulierController.dart';

class TaskEdit extends StatefulWidget {
  const TaskEdit({super.key});
  static const tag = "/TaskEdit";
  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  var isSwitched = false;

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final globalData = Provider.of<GlobalData>(context);

    var nameTaskController = TextEditingController();

    var descriptionController =
        TextEditingController(text: data["description"]);

    var dateStartController = TextEditingController(text: data["start_at"]);
    var dateEndController = TextEditingController(text: data["end_at"]);

    List<String> category = ['Principale', 'Secondaire', 'Autre'];
    String? _dropdownvalue2 = data['type'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              "Modification d'une tâche",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ]),
          Container(
              padding: EdgeInsets.only(top: 30),
              height: 600,
              width: 330,
              child: ListView(shrinkWrap: true, children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: 330,
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    controller: nameTaskController..text = data['name'],
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        label: const Text("Nom de la tâche"),
                        labelStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: 330,
                  child: DropdownButtonFormField<String?>(
                    hint: const Text('Categorie'),
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
                    value: _dropdownvalue2,
                    onChanged: (String? newValue) {
                      setState(() {
                        _dropdownvalue2 = newValue;
                      });
                    },
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 330,
                    child: Center(
                        child: TextField(
                      controller:
                          dateStartController, //editing controller of this TextField
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          label: const Text("Date réalisé de début"),
                          labelStyle: const TextStyle(color: Colors.grey)),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.amberAccent, // <-- SEE HERE
                                  onPrimary: Colors.white, // <-- SEE HERE
                                  onSurface: Colors.black, // <-- SEE HERE
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    foregroundColor: Colors.black,
                                    // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            dateStartController.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ))),
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 330,
                    child: Center(
                        child: TextField(
                      controller:
                          dateEndController, //editing controller of this TextField
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          label: const Text("Date de fin réalisé"),
                          labelStyle: const TextStyle(color: Colors.grey)),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: Colors.amberAccent, // <-- SEE HERE
                                  onPrimary: Colors.white, // <-- SEE HERE
                                  onSurface: Colors.black, // <-- SEE HERE
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    foregroundColor: Colors.black,
                                    // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateEndController =
                                TextEditingController(text: formattedDate);
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ))),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: 330,
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 7,
                    cursorColor: Colors.grey,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        label: const Text("Description"),
                        labelStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
                Container(
                  child: SwitchListTile(
                    title: const Text('Tâche terminé'),
                    value: isSwitched,
                    onChanged: (bool value) {
                      setState(() {
                        isSwitched = value;
                      });
                    },
                    secondary: const Icon(Icons.flag),
                  ),
                )
              ])),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 15, right: 15, left: 15),
                width: 160,
                height: 75,
                child: OutlinedButton(
                  onPressed: () {
                    bool error = false;
                    if (nameTaskController.text == "" ||
                        descriptionController.text == "" ||
                        dateStartController.text == "" ||
                        dateEndController.text == "" ||
                        _dropdownvalue2 == null) {
                      error = true;
                    }
                    if (error == false) {
                      var response = ArtisanController.deleteTask(data['id']);
                      const snackBar = SnackBar(
                        content: Text('Tâche supprimé !'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.of(context).pushNamed(ListTasks.tag);
                    } else {
                      const snackBar = SnackBar(
                        content:
                            Text('Attention à bien remplir le formulaire !'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red)),
                  child: const Text('Supprimer',
                      style: TextStyle(color: Colors.black)),
                )),
            Container(
                padding: const EdgeInsets.only(
                    top: 30, bottom: 15, right: 15, left: 15),
                width: 160,
                height: 75,
                child: OutlinedButton(
                  onPressed: () {
                    bool error = false;
                    if (nameTaskController.text == "" ||
                        descriptionController.text == "" ||
                        dateStartController.text == "" ||
                        dateEndController.text == "" ||
                        _dropdownvalue2 == null) {
                      error = true;
                    }
                    if (error == false) {
                      var response = ArtisanController.updateTask(
                        nameTaskController.text,
                        _dropdownvalue2!,
                        dateStartController.text,
                        dateEndController.text,
                        descriptionController.text,
                        isSwitched,
                        data['id'],
                      );
                      const snackBar = SnackBar(
                        content: Text('Tâche modifié !'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    } else {
                      const snackBar = SnackBar(
                        content:
                            Text('Attention à bien remplir le formulaire !'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.green.withOpacity(0.75),
                      side: const BorderSide(color: Colors.green)),
                  child: const Text('Sauvegarder',
                      style: TextStyle(color: Colors.white)),
                ))
          ])
        ]),
      ),
    );
  }
}
