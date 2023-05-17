import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var firstnameController = TextEditingController();
  var usernameController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmationPasswordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var companyController = TextEditingController();
  var CityController = TextEditingController();
  var AdressController = TextEditingController();
  var PostalCodeController = TextEditingController();
  var siretController = TextEditingController();
  String? _dropdownvalue1;
  List<String> category = ['Electricité', 'Plomberie', 'Maçonnerie'];
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
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: phoneController,
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
                        controller: confirmationPasswordController,
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
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
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
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                      child: DropdownButtonFormField<String?>(
                        hint: const Text('Type d\'entreprise'),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(2),
                        ),
                        items: category.map((value) {
                          return DropdownMenuItem<String>(
                              child: Text(value), value: value);
                        }).toList(),
                        value: _dropdownvalue1,
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropdownvalue1 = newValue;
                          });
                        },
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
                bool error = false;
                bool emailValid =
                    RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        .hasMatch(emailController.text);
                if (emailValid == false) {
                  error = true;
                  const snackBar = SnackBar(
                    content:
                        Text('Error in email ! please select a correct email'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (firstnameController.text.isEmpty ||
                    nameController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    usernameController.text.isEmpty ||
                    phoneController.text.isEmpty ||
                    siretController.text.isEmpty ||
                    AdressController.text.isEmpty ||
                    CityController.text.isEmpty ||
                    PostalCodeController.text.isEmpty ||
                    companyController.text.isEmpty ||
                    _dropdownvalue1 == null) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text('Des champs sont vides !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (phoneController.text.length != 10) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le numéro de téléphone doit contenir 10 chiffres !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (siretController.text.length != 14) {
                  error = true;
                  const snackBar = SnackBar(
                    content:
                        Text('Le numéro de siret doit contenir 14 chiffres !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (phoneController.text[0] != '0') {
                  error = true;
                  const snackBar = SnackBar(
                    content:
                        Text('Le numéro de téléphone doit commencer par 0 !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (PostalCodeController.text.length != 5) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text('Le code postal doit contenir 5 chiffres !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (passwordController.text.length < 8) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le mot de passe doit contenir au moins 8 caractères !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (passwordController.text.contains(new RegExp(r'[A-Z]')) ==
                    false) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le mot de passe doit contenir au moins une majuscule !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (passwordController.text.contains(new RegExp(r'[0-9]')) ==
                    false) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le mot de passe doit contenir au moins un chiffre !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (usernameController.text
                        .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ==
                    true) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le nom d\'utilisateur ne doit pas contenir de caractères spéciaux !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (nameController.text
                        .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ==
                    true) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le nom ne doit pas contenir de caractères spéciaux !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (nameController.text.contains(new RegExp(r'[0-9]')) ==
                    true) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text('Le nom ne doit pas contenir de chiffres !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (firstnameController.text.contains(new RegExp(r'[0-9]')) ==
                    true) {
                  error = true;
                  const snackBar = SnackBar(
                    content:
                        Text('Le prénom ne doit pas contenir de chiffres !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (firstnameController.text
                        .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ==
                    true) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le prénom ne doit pas contenir de caractères spéciaux !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (companyController.text
                        .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ==
                    true) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le nom de l\'entreprise ne doit pas contenir de caractères spéciaux !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (AdressController.text
                        .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ==
                    true) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'L\'adresse ne doit pas contenir de caractères spéciaux !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (CityController.text.contains(new RegExp(r'[0-9]')) ==
                    true) {
                  error = true;
                  const snackBar = SnackBar(
                    content:
                        Text('La ville ne doit pas contenir de chiffres !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (CityController.text
                        .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ==
                    true) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'La ville ne doit pas contenir de caractères spéciaux !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (passwordController.text.contains(new RegExp(r'[a-z]')) ==
                    false) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le mot de passe doit contenir au moins une minuscule !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (passwordController.text.contains(new RegExp(r'[0-9]')) ==
                    false) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le mot de passe doit contenir au moins un chiffre !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (passwordController.text
                        .contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ==
                    false) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text(
                        'Le mot de passe doit contenir au moins un caractère spécial !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

                if (passwordController.text !=
                    confirmationPasswordController.text) {
                  error = true;
                  const snackBar = SnackBar(
                    content: Text('Les mots de passe ne sont pas identiques !'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
                if (error == false) {
                  final checkSiret = await ArtisanController.checkSiretExists(
                      siretController.text);
                  if (checkSiret["statut"] == 200) {
                    if (await ArtisanController.createArtisan(
                          firstnameController.text,
                          nameController.text,
                          passwordController.text,
                          emailController.text,
                          usernameController.text,
                          phoneController.text,
                          siretController.text,
                          'test',
                          AdressController.text,
                          _dropdownvalue1!,
                          companyController.text,
                        ) ==
                        200) {
                      const snackBar = SnackBar(
                        content: Text(
                            'Inscription réussi ! vous pouvez vous connecter'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context).pushNamed(SelectionPage.tag);
                    }
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Le siret n\'est pas valide !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
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
