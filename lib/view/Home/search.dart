import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';

import '../Profile/profileother.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);
  static const tag = "/search";

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Future<Map<String, dynamic>> artisansFuture;
  var inputController = TextEditingController();
  List<String> category = ['Principale', 'Secondaire', 'Autre'];
  List<String> mode = ['Nom', 'Domaine'];
  String? inputDomaine;

  @override
  void initState() {
    super.initState();
    artisansFuture = ArtisanController.getAllArtisan();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: 350,
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
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              value: inputDomaine,
              onChanged: (String? newValue) {
                setState(() {
                  inputDomaine = newValue;
                  inputController.text = "";
                  print(inputDomaine);
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
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
                    hintText: (inputDomaine == "Nom")? "Entrer un nom d'artisan" : "Entrer un nom de domain",
                    labelStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      artisansFuture = ArtisanController.getAllArtisan();
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<Map<String, dynamic>>(
              future: artisansFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Impossible de charger les résultats'),
                  );
                } else {
                  if (snapshot.hasData) {
                    final artisans = snapshot.data;
                    if (snapshot.data?['results'] != null) {
                      List<dynamic> artisanList = artisans?['results'];

                      String searchTerm = inputController.text.trim();

                      List<dynamic> filteredArtisans =
                          artisanList.where((artisan) {
                        if (inputDomaine == 'Nom') {
                          return artisan['name']
                              .toLowerCase()
                              .contains(searchTerm.toLowerCase());
                        } else if (inputDomaine == 'Domaine') {
                          return artisan['domaine']
                              .toLowerCase()
                              .contains(searchTerm.toLowerCase());
                        }
                        return false;
                      }).toList();

                      return Container(
                          padding: EdgeInsets.only(top: 20),
                          child: ListView.builder(
                            itemCount: filteredArtisans.length,
                            itemBuilder: (context, index) {
                              final artisan = filteredArtisans[index];

                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(ProfileOther.tag,
                                            arguments: artisan)
                                        .then((_) => setState(() {}));
                                  },
                                  child: Card(
                                      elevation: 2,
                                      child: ListTile(
                                        title: Text(artisan['name'] +
                                            " " +
                                            artisan['lastname']),
                                        subtitle: Text(artisan['domaine']),
                                        // Add any other relevant information from the artisan object
                                        // to display in the ListTile.
                                      )));
                            },
                          ));
                    } else {
                      return const Center(
                        child: Text('Impossible de charger les résultats'),
                      );
                    }
                  } else {
                    return const Center(
                      child: Text('Impossible de charger les résultats'),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
