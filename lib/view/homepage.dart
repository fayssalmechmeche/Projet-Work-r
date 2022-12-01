import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key, required String title}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body:  Center(child: Text("Home Page !!")),
    );
  }
}
