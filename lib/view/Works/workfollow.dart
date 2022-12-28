import 'package:flutter/material.dart';
class WorkFollow extends StatefulWidget {
  const WorkFollow({Key? key}) : super(key: key);
  static const tag = "/WorkFollow";
  @override
  State<WorkFollow> createState() => _WorkFollowState();
}

class _WorkFollowState extends State<WorkFollow> {
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
      body:  Center(child: Text("Gestion des chantier !!")),
    );
  }
}
