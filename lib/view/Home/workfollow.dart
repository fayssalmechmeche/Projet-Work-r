import 'package:flutter/material.dart';
class WorkFollow extends StatefulWidget {
  const WorkFollow({Key? key}) : super(key: key);

  @override
  State<WorkFollow> createState() => _WorkFollowState();
}

class _WorkFollowState extends State<WorkFollow> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center(child: Text("Gestion des chantier !!")),
    );
  }
}
