import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/view/Home/homepage.dart';
import 'package:my_app/view/Msg/chat.dart';
import 'package:provider/provider.dart';

import '../../Controller/Conversation/ConversationController.dart';
import '../../Controller/global.dart';

class ProfileOther extends StatefulWidget {
  const ProfileOther({super.key});
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
          "Profile",
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
              padding: const EdgeInsets.only(top: 30, left: 40),
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
          Container(
              padding: const EdgeInsets.only(left: 45),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 10),
                      child: Text("Adresse", style: TextStyle(fontSize: 18)),
                    ),
                    Text(data['adress'],
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, bottom: 10),
                              width: 210,
                              child: const Text("Mobilité",
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Text(data['mobilite'],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 10),
                              width: 120,
                              child: const Text("Domaine",
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Text(data['domaine'],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ]),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                top: 20,
                                right: 20,
                              ),
                              width: 210,
                              child: const Text("Mail",
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
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 10),
                              width: 120,
                              child: const Text("Siret",
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Text(data['siret'],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ]),
                    ]),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text("Téléphone", style: TextStyle(fontSize: 18)),
                    ),
                    Text(data['telephone'],
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ])),
          Container(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 15, right: 15, left: 15),
              width: 160,
              height: 85,
              child: OutlinedButton(
                onPressed: () async {
                  bool conversationExists =
                      await ConversationController.checkConversationExists(
                    data['_id'],
                    globalData.getId(),
                  );

                  if (conversationExists == true) {
                    // La conversation existe déjà, effectuer les actions appropriées
                    const snackBar = SnackBar(
                      content: Text('La conversation existe déjà'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    var conversation = await ConversationController
                        .getAllConversationFromArtisanAndParticulier(
                      data['_id'],
                      globalData.getId(),
                    );

                    Navigator.pushNamed(context, Chat.tag, arguments: {
                      "id": conversation["results"][0]['id'],
                      "type": "public"
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
                    const snackBar = SnackBar(
                      content: Text('Conversation créée'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.pushNamed(context, Chat.tag, arguments: {
                      "id": conversation["results"][0]['id'],
                      "type": "public"
                    });
                  }
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green)),
                child: const Text('Contacter',
                    style: TextStyle(color: Colors.black)),
              )),
          Container(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 15, right: 15, left: 15),
              width: 160,
              height: 85,
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
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red)),
                child: const Text('Ajouter aux favoris',
                    style: TextStyle(color: Colors.black)),
              )),
          Container(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 15, right: 15, left: 15),
              width: 160,
              height: 85,
              child: OutlinedButton(
                onPressed: () async {
                  var response = await ParticulierController
                      .removeFavoriteArtisanToParticulier(
                          globalData.getId(), data['_id']);
                  const snackBar = SnackBar(
                    content: Text('Artisan retirés des favoris'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red)),
                child: const Text('Retirer des favoris',
                    style: TextStyle(color: Colors.black)),
              )),
        ]),
      ),
    );
  }
}
