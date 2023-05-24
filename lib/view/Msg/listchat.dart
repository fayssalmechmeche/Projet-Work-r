import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/view/Msg/chat.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';
import '../LunchPage/firstpage.dart';

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

    if (globalData.getRole() == 1) {
      conversations = ParticulierController.getAllConversationsFromParticulier(
          globalData.getId());
    }
    if (globalData.getRole() == 0) {
      conversations =
          ArtisanController.getAllConversationsFromArtisan(globalData.getId());
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
  return const FirstPage(title: '',);
}), (r){
  return false;
});
          },
          icon: Icon(
            Icons.logout,
            color: Colors.red,
          ),
        ),
        title: Text(
          "Mes discussions",
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
    final globalData = Provider.of<GlobalData>(context);
    var dataProfile;
    if (globalData.getRole() == 1) {
      dataProfile =
          ArtisanController.getArtisanById(int.parse(data['artisanID']));
    }
    if (globalData.getRole() == 0) {
      dataProfile = ParticulierController.getParticulierById(
          int.parse(data['particulierID']));
    }

    return GestureDetector(
      onTap: () async {
        final receiver = await dataProfile;

        Map<String, dynamic> arguments = {
          'id': data["id"],
          'type': "public",
          'receiver': receiver['results'][0]['name'] +
              " " +
              receiver['results'][0]['lastname'],
        };
        Navigator.of(context).pushNamed(Chat.tag, arguments: arguments);
      },
      child: Card(
        shape: StadiumBorder(
          side: BorderSide(color: Colors.black, width: 1),
        ),
        elevation: 10,
        color:
            index % 2 == 0 ? Colors.white : Color.fromARGB(255, 190, 188, 188),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: Container(
                width: 20.0,
                height: 20.0,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                    future: dataProfile,
                    builder: (context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data?['results'] != null) {
                            final res = snapshot.data?['results'];
                            return Column(children: [
                              Container(
                                width: 150,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                    res[0]['name'] + " " + res[0]['lastname']),
                              ),
                              Container(
                                width: 150,
                                padding: EdgeInsets.all(10),
                                child: (globalData.getRole() == 1)
                                    ? Text(res[0]['domaine'])
                                    : Text("Particulier"),
                              ),
                            ]);
                          } else {
                            return const Padding(
                                padding: EdgeInsets.only(top: 30),
                                child:
                                    Text('?', style: TextStyle(fontSize: 15)));
                          }
                        } else if (snapshot.hasError) {
                          return const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text('?', style: TextStyle(fontSize: 15)));
                        } else {
                          return const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text('?', style: TextStyle(fontSize: 15)));
                        }
                      } else {
                        return const CircularProgressIndicator(); // or any other widget to show progress
                      }
                    })
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 120),
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
