import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/view/Register/register.dart';
import 'package:my_app/view/Register/registerselection.dart';
import 'package:my_app/view/Login/selectionPage.dart';
import 'package:my_app/Controller/NodeJSManager.dart';

class firstpage extends StatefulWidget {
  const firstpage({Key? key, required String title}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 40),
                width: 200,
                height: 200,
                child: Image.asset("assets/logo.png"),
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Text(
                    "Prenez soin de chez vous depuis votre mobile.",
                    style: TextStyle(fontSize: 12),
                  )),
              Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: 220,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(selectionPage.tag);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      foregroundColor: Colors.yellow,
                    ),
                    child: const Text('Connexion',
                        style: TextStyle(color: Colors.black)),
                  )),
              Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: 220,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterSelectionPage.tag);
                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      foregroundColor: Colors.yellow,
                    ),
                    child: const Text('Inscription',
                        style: TextStyle(color: Colors.black)),
                  )),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 350,
                height: 330,
                child: Image.asset("assets/ouvrier.png"),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
