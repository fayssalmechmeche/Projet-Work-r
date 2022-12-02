import 'package:flutter/material.dart';

import '../Navigation/NavigationPage.dart';

class RegisterArtisan extends StatefulWidget {
  const RegisterArtisan({Key? key, required String title}) : super(key: key);
  static const tag = "/registerartisant";
  @override
  _RegisterArtisanState createState() => _RegisterArtisanState();
}

class _RegisterArtisanState extends State<RegisterArtisan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  child: Image.asset("assets/logo.png"),
                ),
                Row(
                
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 70, right: 10),
                      width: 150,
                      height: 150,
                      child: TextFormField(
                        cursorColor: Colors.grey,
/*                         controller: nameController,
 */                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(90),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: "Nom",
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 70,left: 10),
                      
                      width: 150,
                      height: 150,
                      child: TextFormField(
                        cursorColor: Colors.grey,
/*                         controller: nameController,
 */                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(90),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            labelText: "Prenom",
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 0),
                      width: 300,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: "Numero de telephone",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: 300,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: "Adresse",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: 300,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: "Mot de passe",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: 300,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: "Repeter mote de passe ",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: 300,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(90.0),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          labelText: "Numero de siret",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 35),
                      width: 130,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          foregroundColor: Colors.yellow,
                        ),
                        child: const Text('Inscription',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}