import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/view/selectionPage.dart';
import 'package:my_app/Controller/NodeJSManager.dart';

class firstpage extends StatefulWidget {
  const firstpage({Key? key, required String title}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
 Future<void> createUser() async {
   var url = "http://10.0.2.2:3000/";
   var response = await http.post(Uri.parse("${url}authenticate"),headers:<String, String>{
     'Content-Type': 'application/json; charset=UTF-8',
   },body: jsonEncode(<String, String>{
   'name': "admin",'password':"admin"}));
   print('Response status: ${response.statusCode}');
   print('Response body: ${response.body}');
   print( response.body);
 }



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
                      createUser();
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
                    onPressed: () {},
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
