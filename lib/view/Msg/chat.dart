import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Conversation/ConversationController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  static const tag = "/ChatPage";

  @override
  State<Chat> createState() => _ChatPageState();
}

class _ChatPageState extends State<Chat> {
  final inputController = TextEditingController();

  var conversation;

  @override
  void initState() {
    super.initState();
    // Simulation des messages
  }

  getConversation() async {
    final data = ModalRoute.of(context)!.settings.arguments as Map;

    if (data["type"] == "private") {
      conversation = await ConversationController.getOneConversationFromWork(
          data["chantier"]["id"]);

      return conversation["results"][0]["id"];
    } else {}
  }

  Future<Map<String, dynamic>> getAllMessage() async {
    var messages = await ConversationController.getAllMessageFromConversation(
        await getConversation());
    print("messages");
    print(messages["results"]);

    return messages;
  }

  @override
  Widget build(BuildContext context) {
    getAllMessage();
    getConversation();
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final globalData = Provider.of<GlobalData>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const BackButton(
            color: Colors.black,
          ),
          title: const Text(
            "Chat",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          toolbarHeight: 35,
          elevation: 0,
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: getAllMessage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // En attente de la récupération de la conversation
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Erreur lors de la récupération de la conversation
              return Center(child: Text('Erreur : ${snapshot.error}'));
            } else {
              final conversation = snapshot.data;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!["results"].length,
                      itemBuilder: (context, index) {
                        return _buildMessageItem(
                            snapshot.data!["results"][index]);
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: inputController,
                            decoration: const InputDecoration(
                              hintText: "Écrire un message...",
                            ),
                            onSubmitted: (text) async {
                              ConversationController.sendMessage(
                                await getConversation(),
                                globalData.getId(),
                                globalData.getUsername(),
                                globalData.getRole().toString(),
                                text,
                              );
                              setState(() {});
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            await ConversationController.sendMessage(
                              await getConversation(),
                              globalData.getId(),
                              globalData.getUsername(),
                              globalData.getRole().toString(),
                              inputController.text,
                            );
                            setState(() {});
                            inputController.clear();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> message) {
    final globalData = Provider.of<GlobalData>(context);
    var pseudo;

    final isMyMessage = message["senderID"] == globalData.getId();

    final alignment =
        isMyMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final backgroundColor =
        isMyMessage ? Colors.grey[300] : Colors.yellow.withOpacity(0.5);
    final textColor = isMyMessage ? Colors.black : Colors.black;
    DateTime date = DateTime.parse(message["date"]);

    String formattedDate = DateFormat('dd-MM-yyyy à HH:mm:ss').format(date);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            message["pseudo"] + " " + formattedDate,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message["content"],
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}
