import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/view/Home/homepage.dart';
import 'package:my_app/view/Msg/chat.dart';
import 'package:provider/provider.dart';

import '../../Controller/Conversation/ConversationController.dart';
import '../../Controller/Note/NoteController.dart';
import '../../Controller/global.dart';

class ProfileOther extends StatefulWidget {
  const ProfileOther({Key? key}) : super(key: key);
  static const tag = "/ProfileOther";
  @override
  State<ProfileOther> createState() => _ProfileOtherState();
}

class _ProfileOtherState extends State<ProfileOther> {
  var exist;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite();
  }

  void isFavorite() async {
    final data = ModalRoute.of(context)!.settings.arguments as Map;

    final globalData = Provider.of<GlobalData>(context);
    exist = await ConversationController.checkConversationExists(
      data['_id'],
      globalData.getId(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final globalData = Provider.of<GlobalData>(context);
    final allNote = NoteController.getNoteByArtisan(data['_id']);
    final checkFav = ParticulierController.getFavoriteArtisanOfParticulier(
        globalData.getId());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Profil",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 45,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(children: [
          Container(
              padding: const EdgeInsets.only(top: 20, left: 40),
              child: Row(children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: data["picture"] != "null"
                            ? NetworkImage(data["picture"])
                            : NetworkImage(
                                "https://avatars.githubusercontent.com/u/77855537?s=40&v=4"),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(left: 60),
                  child: Column(children: [
                    Text(data['name'] + "  " + data['lastname'],
                        style: TextStyle(fontSize: 18)),
                    Text(data['entreprise'],
                        style: TextStyle(fontSize: 18, color: Colors.red[900])),
                  ]),
                )
              ])),
          SizedBox(
              height: 504,
              child: ListView(shrinkWrap: true, children: [
                Container(
                    padding: const EdgeInsets.only(left: 45),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 210,
                            padding: EdgeInsets.only(top: 40, bottom: 10),
                            child:
                                Text("Adresse", style: TextStyle(fontSize: 18)),
                          ),
                          Text(data['adress'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        width: 120,
                                        child: const Text("Domaine",
                                            style: TextStyle(fontSize: 18)),
                                      ),
                                      Text(data['domaine'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey)),
                                    ]),
                              ]),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 20,
                              right: 20,
                            ),
                            width: 210,
                            child: const Text("Email",
                                style: TextStyle(fontSize: 18)),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 10, right: 20, bottom: 10),
                            width: 210,
                            child: Text(data['email'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            width: 120,
                            child: const Text("Siret",
                                style: TextStyle(fontSize: 18)),
                          ),
                          Text(data['siret'],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                          const Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 10),
                            child: Text("Téléphone",
                                style: TextStyle(fontSize: 18)),
                          ),
                          Text(data['telephone'],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey)),
                        ])),
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 330,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            height: 105,
                            child: Column(
                              children: [
                                const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text("Note de l'artisan",
                                        style: TextStyle(fontSize: 18))),
                                FutureBuilder(
                                    future: allNote,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        if (snapshot.hasData) {
                                          var results =
                                              snapshot.data?['results'];
                                          late double note;

                                          print(results);
                                          if (results != null &&
                                              results.isNotEmpty) {
                                            double total = 0;
                                            results.forEach((item) {
                                              total = total + item['note'];
                                            });
                                            note = total / results.length;
                                          } else {
                                            note = 0;
                                          }

                                          return Column(
                                            children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: RatingOfProfile(note)),
                                              Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Text('${note} / 5',
                                                      style: TextStyle(
                                                          fontSize: 15)))
                                            ],
                                          );
                                        } else if (snapshot.hasError) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: RatingOfProfile(0));
                                        } else {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: RatingOfProfile(0));
                                        }
                                      } else {
                                        return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: RatingOfProfile(
                                                0)); // or any other widget to show progress
                                      }
                                    })
                              ],
                            ))
                      ],
                    )),
              ])),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 15, right: 15, left: 15),
                width: 160,
                height: 65,
                child: OutlinedButton(
                  onPressed: () async {
                    bool conversationExists =
                        await ConversationController.checkConversationExists(
                      data['_id'],
                      globalData.getId(),
                    );

                    if (conversationExists == true) {
                      // La conversation existe déjà, effectuer les actions appropriées

                      var conversation = await ConversationController
                          .getAllConversationFromArtisanAndParticulier(
                        data['_id'],
                        globalData.getId(),
                      );

                      Navigator.pushNamed(context, Chat.tag, arguments: {
                        "id": conversation["results"][0]['id'],
                        "type": "public",
                        'receiver': data['name'] + " " + data['lastname']
                      });
                    } else {
                      // Créer une nouvelle conversation
                      await ConversationController.createConversation(
                          data['_id'], globalData.getId(), "conversation");
                      var conversation = await ConversationController
                          .getAllConversationFromArtisanAndParticulier(
                        data['_id'],
                        globalData.getId(),
                      );

                      Navigator.pushNamed(context, Chat.tag, arguments: {
                        "id": conversation["results"][0]['id'],
                        "type": "public",
                        'receiver': data['name'] + " " + data['lastname']
                      });
                    }
                  },
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      foregroundColor: Colors.green,
                      backgroundColor: Colors.green.withOpacity(0.75),
                      side: const BorderSide(color: Colors.green)),
                  child: const Text('Contacter',
                      style: TextStyle(color: Colors.white)),
                )),
            FutureBuilder(
              future: checkFav,
              builder: (context, snapshot) {
                var isCheckFav = false;
                if (snapshot.hasData) {
                  var results = snapshot.data?['results'];
                  if (results != null && results.isNotEmpty) {
                    results.forEach((item) {
                      if (item['_id'] == data['_id']) {
                        isCheckFav = true;
                      }
                    });
                  }
                  if (isCheckFav == true) {
                    return Container(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 15, right: 15, left: 15),
                      width: 160,
                      height: 70,
                      child: OutlinedButton(
                        onPressed: () async {
                          var response = await ParticulierController
                              .removeFavoriteArtisanToParticulier(
                                  globalData.getId(), data['_id']);
                          const snackBar = SnackBar(
                            content: Text('Artisan retiré des favoris'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            foregroundColor: Colors.red,
                            backgroundColor: Colors.red.withOpacity(0.75),
                            side: const BorderSide(color: Colors.red)),
                        child: const Text('Retirer des favoris',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 15, right: 15, left: 15),
                      width: 160,
                      height: 70,
                      child: OutlinedButton(
                        onPressed: () async {
                          var response = await ParticulierController
                              .addFavoriteArtisanToParticulier(
                                  globalData.getId(), data['_id']);
                          const snackBar = SnackBar(
                            content: Text('Artisan ajouté aux favoris'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            foregroundColor: Colors.green,
                            backgroundColor: Colors.green.withOpacity(0.75),
                            side: const BorderSide(color: Colors.green)),
                        child: const Text('Ajouter aux favoris',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text('');
                } else {
                  return Text('');
                }
              },
            )
          ]),
        ]),
      ),
    );
  }

  Widget RatingOfProfile(double rating) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      DecoratedIcon(
        icon: Icon(
          rating > 0 && rating < 1 ? Icons.star_half : Icons.star,
          color: rating > 0 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration: const IconDecoration(
            border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 1.0 && rating < 2.0 ? Icons.star_half : Icons.star,
          color: rating > 1 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration: const IconDecoration(
            border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 2.0 && rating < 3.0 ? Icons.star_half : Icons.star,
          color: rating > 2 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration: const IconDecoration(
            border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 3.0 && rating < 4.0 ? Icons.star_half : Icons.star,
          color: rating > 3 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration: const IconDecoration(
            border: IconBorder(color: Colors.black, width: 2)),
      ),
      DecoratedIcon(
        icon: Icon(
          rating > 4.0 && rating < 5.0 ? Icons.star_half : Icons.star,
          color: rating > 4 ? Colors.yellow : Colors.black,
          size: 25,
        ),
        decoration: const IconDecoration(
            border: IconBorder(color: Colors.black, width: 2)),
      ),
    ]);
  }
}
