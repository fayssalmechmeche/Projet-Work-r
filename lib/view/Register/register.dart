import 'package:flutter/material.dart';
import 'package:my_app/Controller/NodeJSManager.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/view/Login/selectionPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required String title}) : super(key: key);
  static const tag = "/register";

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    var firstnameController = TextEditingController();
    var usernameController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var telephoneController = TextEditingController();
    var adressController = TextEditingController();
    var PostalCodeController = TextEditingController();
    var emailController = TextEditingController();
    var cityController = TextEditingController();
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
            padding: EdgeInsets.only(bottom: 10),
            width: 150,
            height: 160,
            child: Image.asset("assets/logo.png"),
          ),
          SizedBox(
            height: 460,
            child: ListView(
              shrinkWrap: true,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 20, right: 10),
                      width: 150,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        controller: firstnameController,
                        decoration: InputDecoration(
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
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      width: 150,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        controller: nameController,
                        decoration: InputDecoration(
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
                      padding: const EdgeInsets.only(top: 20),
                      width: 300,
                      child: TextFormField(
                        controller: usernameController,
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
                          labelText: "Nom d'utilisateur",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: 300,
                      child: TextFormField(
                        controller: telephoneController,
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
                      padding: const EdgeInsets.only(top: 20),
                      width: 300,
                      child: TextFormField(
                        controller: emailController,
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
                          labelText: "Adresse mail",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: 300,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        controller: adressController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            label: const Text("Adresse"),
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        padding: const EdgeInsets.only(top: 20, right: 10),
                        width: 170,
                        child: TextFormField(
                          cursorColor: Colors.grey,
                          controller: cityController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              label: const Text("Ville"),
                              labelStyle: const TextStyle(color: Colors.grey)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: 130,
                        child: TextFormField(
                          cursorColor: Colors.grey,
                          controller: PostalCodeController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(90.0),
                              ),
                              contentPadding: const EdgeInsets.all(10),
                              label: const Text("Code Postale"),
                              labelStyle: const TextStyle(color: Colors.grey)),
                        ),
                      )
                    ]),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: 300,
                      child: TextFormField(
                        controller: passwordController,
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
                      padding: const EdgeInsets.only(top: 20),
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

                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 20),
              width: 150,
              height: 55,
              child: OutlinedButton(
                onPressed: () async => {
                  if (await ParticulierController.createParticulier(
                      "${firstnameController.text + nameController.text}",
                      passwordController.text,
                      emailController.text,
                      usernameController.text,
                      telephoneController.text,
                      cityController.text,
                      adressController.text,
                      PostalCodeController.text) ==
                      200)
                    {
                      Navigator.of(context)
                          .pushNamed(SelectionPage.tag)
                    }
                },
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  foregroundColor: Colors.yellow,
                ),
                child: const Text('Inscription',
                    style: TextStyle(color: Colors.black)),
              )),
        ],
      )),
    );
  }
}
