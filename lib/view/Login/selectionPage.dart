import 'package:flutter/material.dart';
import 'package:my_app/view/Login/login.dart';
import 'package:my_app/view/Login/loginart.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);
  static const tag = "/selection";
  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          Container(
            width: 150,
            height: 150,
            child: Image.asset("assets/logo.png"),
          ),
          const Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text(
                "Je me connecte en tant que :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )),
          Container(
              padding: const EdgeInsets.only(top: 40),
              width: 220,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Login.tag);
                },
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.yellow,
                ),
                child: const Text('Particulier',
                    style: TextStyle(color: Colors.black)),
              )),
          Row(children: <Widget>[
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                  child: const Divider(
                    color: Colors.black,
                    thickness: 2,
                    height: 36,
                  )),
            ),
            const Text("OU"),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                  child: const Divider(
                    color: Colors.black,
                    thickness: 2,
                    height: 36,
                  )),
            ),
          ]),
          Container(
              padding: const EdgeInsets.only(top: 10),
              width: 220,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(LoginArt.tag);
                },
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.yellow,
                ),
                child: const Text('Artisan',
                    style: TextStyle(color: Colors.black)),
              ))
        ]),
      ),
    );
  }
}
