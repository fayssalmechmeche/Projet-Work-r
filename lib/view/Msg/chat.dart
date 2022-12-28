import 'package:flutter/material.dart';
class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);
  static const tag = "/Chat";
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
            color: Colors.black
        ),
        elevation: 0,
      ),
      body:  Center(child: Text("Chat !!")),
    );
  }
}
