import 'package:flutter/material.dart';
class login extends StatefulWidget {
  const login({Key? key, required String title}) : super(key: key);
  static const tag = "/login";
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(

        body: SafeArea(
            child: Text("gkjgkj"),
        )
    );
  }
}
