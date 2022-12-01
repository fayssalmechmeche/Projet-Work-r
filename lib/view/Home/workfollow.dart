import 'package:flutter/material.dart';
class workfollow extends StatefulWidget {
  const workfollow({Key? key}) : super(key: key);

  @override
  State<workfollow> createState() => _workfollowState();
}

class _workfollowState extends State<workfollow> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center(child: Text("Gestion des chantier !!")),
    );
  }
}
