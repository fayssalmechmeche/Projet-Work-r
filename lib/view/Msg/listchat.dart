import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/view/Msg/chat.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';

class ListChat extends StatefulWidget {
  const ListChat({Key? key}) : super(key: key);

  @override
  State<ListChat> createState() => _ListChatState();
}

class _ListChatState extends State<ListChat> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);

    var conversations;
    print("role");
    print(globalData.getRole());
    if (globalData.getRole() == 1) {
      conversations = ParticulierController.getAllConversationsFromParticulier(
          globalData.getId());
    }
    if (globalData.getRole() == 0) {
      conversations = ArtisanController.getAllConversationsFromArtisan(
          globalData.getId());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.logout,
            color: Colors.red,
          ),
        ),
        title: Text(
          "Mes Devis",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 45,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Visibility(
            visible: true,
            child: SizedBox(
              height: 50,
              width: 350,
            ),
          ),
          chantiersList(conversations),
        ],
      ),
    );
  }

  Widget chantiersList(conversation) {
    return FutureBuilder(
      future: conversation,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['results'] == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Aucune proposition de devis"),
                ],
              ),
            );
          }
          if (snapshot.data['results'].length != 0) {
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data['results'].length,
                itemBuilder: (BuildContext context, int index) {
                  return CardChat(index, snapshot.data['results'][index]);
                },
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Aucun chantier disponible"),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget CardChat(int index, data) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Chat.tag);
        final snackBar = SnackBar(
          content: Text('Page message has been launched'),
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
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Plombier"),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Phillipe"),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 150),
              height: 50,
              width: 50,
              child: Icon(Icons.arrow_forward_ios),
            ),
          ],
        ),
      ),
    );
  }
}
