import 'package:flutter/material.dart';
import 'package:my_app/view/Navigation/navigationpage.dart';
import 'package:my_app/view/Register/register.dart';
import 'package:my_app/view/Register/registerartisant.dart';

class RegisterSelectionPage extends StatefulWidget {
  const RegisterSelectionPage({Key? key}) : super(key: key);
  static const tag = "/registerselection";
  @override
  State<RegisterSelectionPage> createState() => _RegisterSelectionPageState();
}

class _RegisterSelectionPageState extends State<RegisterSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              child: Image.asset("assets/logo.png"),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 80),
                child: Text(
                  "Je m'inscris en tant que :",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            Container(
              padding: const EdgeInsets.only(top: 40),
              width: 220,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(RegisterPage.tag);
                },
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.yellow,
                ),
                child: const Text('Particulier',
                    style: TextStyle(color: Colors.black)),
              ),
            ),
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
                  Navigator.of(context).pushNamed(RegisterArtisan.tag);
                },
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.yellow,
                ),
                child: const Text('Artisan',
                    style: TextStyle(color: Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
