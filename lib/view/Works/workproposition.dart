import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class WorkProposition extends StatefulWidget {
  const WorkProposition({Key? key}) : super(key: key);
  static const tag = "/WorkProposition";

  @override
  State<WorkProposition> createState() => _WorkPropositionState();
}

class _WorkPropositionState extends State<WorkProposition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
            color: Colors.black
        ),
        elevation: 0,
      ),
      body:  Center(child: Text("Page info de chantier")),
    );;
  }
}