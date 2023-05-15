import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Conversation/ConversationController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:provider/provider.dart';

import '../../Controller/MessageProvider.dart';
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
    getAllMessage();
    getConversation();
  }

  getConversation() async {
    final data = ModalRoute.of(context)!.settings.arguments as Map;

    if (data["type"] == "public") {
      // Traiter le cas "public"
      conversation =
          await ConversationController.getOneConversation(data["id"]);

      return conversation["results"][0]["id"];
    } else {
      // Traiter le cas "private"
      conversation = await ConversationController.getOneConversationFromWork(
          data["chantier"]);
      return conversation["results"][0]["id"];
    }
  }

  Future<Map<String, dynamic>> getAllMessage() async {
    final messageProvider = Provider.of<MessageProvider>(context);
    messageProvider.clearMessages();

    final data = ModalRoute.of(context)!.settings.arguments as Map;
    if (data["type"] == "public") {
      // Traiter le cas "public"
      var messages =
          await ConversationController.getAllMessageFromPublicConversation(
              await getConversation());
      return messages;
    } else {
      // Traiter le cas "private"

      var messages = await ConversationController.getAllMessageFromConversation(
          await getConversation());

      return messages;
    }
  }

  @override
  Widget build(BuildContext context) {
    final messageProvider = Provider.of<MessageProvider>(context);

    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final globalData = Provider.of<GlobalData>(context);
    final socket = globalData.getSocket();
    socket!.on("message", (data) {
      messageProvider.addMessage(data);
    });

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
              final messages = messageProvider.messages;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!["results"].length,
                      itemBuilder: (context, index) {
                        messageProvider
                            .addMessage(snapshot.data!["results"][index]);
                        return _buildMessageItem(messages[index]);
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
                              if (inputController.text.isEmpty) return;

                              if (data["type"] == "public") {
                                await ConversationController.sendMessagePublic(
                                  await getConversation(),
                                  globalData.getId(),
                                  globalData.getUsername(),
                                  globalData.getRole().toString(),
                                  inputController.text,
                                );
                                socket.emit('message', {
                                  "pseudo": globalData.getUsername(),
                                  "content": inputController.text,
                                  "senderID": globalData.getId(),
                                  "date": DateTime.now().toString()
                                });
                              } else {
                                await ConversationController.sendMessage(
                                  await getConversation(),
                                  globalData.getId(),
                                  globalData.getUsername(),
                                  globalData.getRole().toString(),
                                  inputController.text,
                                );
                                socket.emit('message', {
                                  "pseudo": globalData.getUsername(),
                                  "content": inputController.text,
                                  "senderID": globalData.getId(),
                                  "date": DateTime.now().toString()
                                });
                              }
                              inputController.clear();
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            if (inputController.text.isEmpty) return;

                            if (data["type"] == "public") {
                              await ConversationController.sendMessagePublic(
                                await getConversation(),
                                globalData.getId(),
                                globalData.getUsername(),
                                globalData.getRole().toString(),
                                inputController.text,
                              );
                              socket.emit('message', {
                                "pseudo": globalData.getUsername(),
                                "content": inputController.text,
                                "senderID": globalData.getId(),
                                "date": DateTime.now().toString()
                              });
                            } else {
                              await ConversationController.sendMessage(
                                await getConversation(),
                                globalData.getId(),
                                globalData.getUsername(),
                                globalData.getRole().toString(),
                                inputController.text,
                              );
                              socket.emit('message', {
                                "pseudo": globalData.getUsername(),
                                "content": inputController.text,
                                "senderID": globalData.getId(),
                                "date": DateTime.now().toString()
                              });
                            }
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

    final isMyMessage = message["senderID"] == globalData.getId();

    final alignment =
        isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start;
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
