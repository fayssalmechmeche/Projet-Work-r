import 'package:flutter/material.dart';
import 'package:my_app/Controller/Conversation/ConversationController.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  static const tag = "/ChatPage";

  @override
  State<Chat> createState() => _ChatPageState();
}

class _ChatPageState extends State<Chat> {
  List<Message> messages = [];
  final inputController = TextEditingController();

  var conversation;

  @override
  void initState() {
    super.initState();
    // Simulation des messages
    messages = [
      Message(sender: "John", text: "Salut !"),
      Message(sender: "Alice", text: "Bonjour John !"),
      Message(sender: "John", text: "Comment ça va ?"),
      Message(sender: "Alice", text: "Je vais bien, merci ! Et toi ?"),
      Message(sender: "John", text: "Ça va aussi."),
    ];
  }

  void sendMessage(String text) {
    setState(() {
      messages.add(Message(sender: "John", text: text));
    });
  }

  getConversation() async {
    final data = ModalRoute.of(context)!.settings.arguments as Map;

    if (data["type"] == "private") {
      conversation = await ConversationController.getOneConversationFromWork(
          data["chantier"]["id"]);

      return conversation["results"][0]["id"];
    } else {}
  }

  getAllMessage() async {
    var messages = await ConversationController.getAllMessageFromConversation(
        await getConversation());

    return messages["results"];
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
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return _buildMessageItem(message);
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
                            onSubmitted: (text) {
                              sendMessage(text);
                            },
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () async {
                            await ConversationController.sendMessage(
                              getConversation(),
                              globalData.getId(),
                              globalData.getRole().toString(),
                              inputController.text,
                            );
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

  Widget _buildMessageItem(message) {
    final isMyMessage = message.sender == "John";
    final alignment =
        isMyMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final backgroundColor =
        isMyMessage ? Colors.grey[300] : Colors.yellow.withOpacity(0.5);
    final textColor = isMyMessage ? Colors.black : Colors.black;

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
            message.sender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message.text,
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String sender;
  final String text;

  Message({required this.sender, required this.text});
}
