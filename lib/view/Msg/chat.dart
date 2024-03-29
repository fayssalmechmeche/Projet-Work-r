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
  ScrollController _scrollController = ScrollController();

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    // Simulation des messages
    getAllMessage();
    getConversation();

    _scrollController = ScrollController();
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
      scrollToBottom();
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Container(
          width: 200,
          child: Text(
            data["receiver"],
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        toolbarHeight: 35,
        elevation: 0,
      ),
      body: SafeArea(
          child: Column(children: [
        FutureBuilder<Map<String, dynamic>>(
          future: getAllMessage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // En attente de la récupération de la conversation
              return const Expanded(child: Center(child: Text("")));
            } else if (snapshot.hasError) {
              // Erreur lors de la récupération de la conversation
              return Expanded(
                  child: Center(child: Text('Erreur : ${snapshot.error}')));
            } else {
              final conversation = snapshot.data;
              final messages = messageProvider.messages;
              WidgetsBinding.instance!.addPostFrameCallback((_) {
                // Faites défiler jusqu'au dernier message après que le widget soit construit
                scrollToBottom();
              });

              return Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!["results"].length,
                  itemBuilder: (context, index) {
                    messageProvider
                        .addMessage(snapshot.data!["results"][index]);
                    return _buildMessageItem(messages[index]);
                  },
                ),
              );
            }
          },
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
                    if (data["type"] == "public") {
                      await ConversationController.sendMessagePublic(
                        await getConversation(),
                        globalData.getId(),
                        globalData.getUsername(),
                        globalData.getRole().toString(),
                        inputController.text,
                      );
                      socket!.emit('message', {
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
                      socket!.emit('message', {
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
                    socket!.emit('message', {
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
                    socket!.emit('message', {
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
      ])),
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

    String formattedDate = DateFormat('dd/MM/yyyy à HH:mm:ss').format(date);

    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment:
          isMyMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: alignment,
            children: <Widget>[
              Text(
                message["content"],
                style: TextStyle(
                  color: textColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
