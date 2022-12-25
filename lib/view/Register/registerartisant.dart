import 'package:dropdown_search/dropdown_search.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';

import '../Login/SelectionPage.dart';
import '../Navigation/NavigationPage.dart';

class RegisterArtisan extends StatefulWidget {
  const RegisterArtisan({Key? key, required String title}) : super(key: key);
  static const tag = "/registerartisant";
  @override
  _RegisterArtisanState createState() => _RegisterArtisanState();
}

class _RegisterArtisanState extends State<RegisterArtisan> {
  @override
  String dropdownvalue = 'Domaine';

  var items = [
    'Domaine',
    'Plombier',
    'Maçon',
    'Carreleur',
    'Electricien',
  ];

  Widget build(BuildContext context) {
    var firstnameController = TextEditingController();
    var usernameController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var emailController = TextEditingController();
    var telephoneController = TextEditingController();
    var companyController = TextEditingController();
    var CityController = TextEditingController();
    var AdressController = TextEditingController();
    var PostalCodeController = TextEditingController();
    var siretController = TextEditingController();
    var domaineController = SingleValueDropDownController();
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
                            labelText: "Nom",
                            labelStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20, left: 10),
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
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: 300,
                      child: TextFormField(
                        controller: companyController,
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
                          labelText: "Nom de l'entreprise",
                          labelStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: 300,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        controller: AdressController,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20, right: 10),
                          width: 170,
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            controller: CityController,
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
                                labelStyle:
                                    const TextStyle(color: Colors.grey)),
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
                                labelStyle:
                                    const TextStyle(color: Colors.grey)),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: 300,
                      child: TextFormField(
                        controller: siretController,
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
                          labelStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: 300,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors
                              .white, //background color of dropdown button
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(90),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: DropDownTextField(
                            controller: domaineController,
                            dropDownItemCount: items.length,
                            dropDownList: [
                              DropDownValueModel(
                                  name: items[0].toString(), value: items[0]),
                              DropDownValueModel(
                                  name: items[1].toString(), value: items[1]),
                              DropDownValueModel(
                                  name: items[2].toString(), value: items[2]),
                              DropDownValueModel(
                                  name: items[3].toString(), value: items[3]),
                              DropDownValueModel(
                                  name: items[4].toString(), value: items[4]),
                            ],
                          ),
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
            width: 130,
            child: OutlinedButton(
              onPressed: () async {
                if (await ArtisanController.createArtisan(
                      "${firstnameController.text + nameController.text}",
                      passwordController.text,
                      emailController.text,
                      usernameController.text,
                      telephoneController.text,
                      siretController.text,
                      AdressController.text,
                      companyController.text,
                    ) ==
                    200) {
                  Navigator.of(context).pushNamed(SelectionPage.tag);
                }
              },
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                foregroundColor: Colors.yellow,
              ),
              child: const Text('Inscription',
                  style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      )),
    );
  }
}
