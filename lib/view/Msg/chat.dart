import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  static const tag = "/ChatPage";

  @override
  State<Chat> createState() => _ChatPageState();
}

class _ChatPageState extends State<Chat> {
  List<Message> messages = [];
  final inputController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
                  onPressed: () {
                    final text = sendMessage(
                        inputController.text); // récupère le texte et l'envoie
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildMessageItem(Message message) {
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
