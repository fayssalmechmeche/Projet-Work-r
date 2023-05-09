import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Search extends StatefulWidget {
  const Search({super.key});
  static const tag = "/search";
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    var inputController = TextEditingController();
    List<String> category = ['Principale', 'Secondaire', 'Autre'];
    List<String> mode = ['Nom', 'Domaine'];
    String? inputDomaine;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(
            color: Colors.black,
          ),
          title: const Text(
            "Recherche d'artisan",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 35,
          elevation: 0,
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: 330,
            child: DropdownButtonFormField<String?>(
              hint: const Text('Type de recherche'),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                contentPadding: const EdgeInsets.all(2),
              ),
              items: mode.map((value) {
                return DropdownMenuItem<String>(
                    child: Text(value), value: value);
              }).toList(),
              value: inputDomaine,
              onChanged: (String? newValue) {
                setState(() {
                  inputDomaine = newValue;
                  print(inputDomaine);
                });
              },
            ),
          ),
         
           
           
               Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: const EdgeInsets.only(top: 30),
                  width: 300,
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    controller: inputController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(90.0),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        hintText: "Entrer un nom d'artisan",
                        labelStyle: const TextStyle(color: Colors.grey)),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        icon: const Icon(Icons.search, size: 20),
                        onPressed: () {})),
                 ])
        ]));
  }
}
