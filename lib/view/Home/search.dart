import 'package:flutter/material.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';

import '../../Controller/Note/NoteController.dart';
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
      resizeToAvoidBottomInset: false,
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
                    hintText: (inputDomaine == "Nom")
                        ? "Entrez un nom d'artisan"
                        : "Entrez un nom de domaine",
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
                              final allNote = NoteController.getNoteByArtisan(
                                  filteredArtisans[index]['_id']);
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(ProfileOther.tag,
                                            arguments: artisan)
                                        .then((_) => setState(() {}));
                                  },
                                  child: Card(
                                      shape: const StadiumBorder(
                                        //<-- 3. SEE HERE
                                        side: BorderSide(
                                          color: Colors.grey,
                                          width:
                                              1.0, //index % 2 == 0 ? 1.0 : 0.0,
                                        ),
                                      ),
                                      elevation: 10,
                                      color: Colors.white,
                                      //index % 2 == 0 ? Colors.white : Colors.grey,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding:
                                                const EdgeInsets.only(left: 25),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 200,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Text(
                                                          artisan['name'] +
                                                              " " +
                                                              artisan[
                                                                  'lastname'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                  Container(
                                                    width: 200,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5,
                                                            right: 2,
                                                            top: 2,
                                                            bottom: 2),
                                                    child: Text(
                                                        artisan['domaine']),
                                                  ),
                                                  FutureBuilder(
                                                      future: allNote,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          if (snapshot
                                                              .hasData) {
                                                            var results =
                                                                snapshot.data?[
                                                                    'results'];
                                                            late double note;

                                                            if (results !=
                                                                    null &&
                                                                results
                                                                    .isNotEmpty) {
                                                              double total = 0;
                                                              results.forEach(
                                                                  (item) {
                                                                total = total +
                                                                    item[
                                                                        'note'];
                                                              });
                                                              note = total /
                                                                  results
                                                                      .length;
                                                            } else {
                                                              note = 0;
                                                            }

                                                            return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    RatingOfProfile(
                                                                        note));
                                                          } else if (snapshot
                                                              .hasError) {
                                                            return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    RatingOfProfile(
                                                                        0));
                                                          } else {
                                                            return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child:
                                                                    RatingOfProfile(
                                                                        0));
                                                          }
                                                        } else {
                                                          return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5),
                                                              child: RatingOfProfile(
                                                                  0)); // or any other widget to show progress
                                                        }
                                                      })
                                                ]),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 105),
                                              height: 50,
                                              width: 50,
                                              child: const Icon(
                                                  Icons.arrow_forward_ios))
                                        ],
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

  Widget RatingOfProfile(double rating) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      DecoratedIcon(
        icon: Icon(
          rating > 0 && rating < 1 ? Icons.star_half : Icons.star,
          color: rating > 0 ? Colors.yellow : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 1.0 && rating < 2.0 ? Icons.star_half : Icons.star,
          color: rating > 1 ? Colors.yellow : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 2.0 && rating < 3.0 ? Icons.star_half : Icons.star,
          color: rating > 2 ? Colors.yellow : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 3.0 && rating < 4.0 ? Icons.star_half : Icons.star,
          color: rating > 3 ? Colors.yellow : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 4.0 && rating < 5.0 ? Icons.star_half : Icons.star,
          color: rating > 4 ? Colors.yellow : Colors.black,
          size: 16,
        ),
        decoration:
            IconDecoration(border: IconBorder(color: Colors.black, width: 2)),
      ),
    ]);
  }
}
