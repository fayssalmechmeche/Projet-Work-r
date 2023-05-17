import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    var confirmPasswordController = TextEditingController();
    var telephoneController = TextEditingController();
    var adressController = TextEditingController();
    var PostalCodeController = TextEditingController();
    var emailController = TextEditingController();
    var cityController = TextEditingController();
    bool emailValid;
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
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
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
                        controller: confirmPasswordController,
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
                onPressed: () {
                  bool error = false;
                  bool emailValid =
                      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(emailController.text);
                  if (emailValid == false) {
                    error = true;
                    const snackBar = SnackBar(
                      content: Text('L\'adresse mail n\'est pas valide !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  if (cityController.text.contains(new RegExp(r'[0-9]'))) {
                    error = true;
                    const snackBar = SnackBar(
                      content: Text(
                          'Le nom de la ville ne doit pas contenir de chiffre !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  if (PostalCodeController.text.length != 5) {
                    error = true;
                    const snackBar = SnackBar(
                      content:
                          Text('Le code postale doit contenir 5 chiffres !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  if (telephoneController.text.length != 10) {
                    error = true;
                    const snackBar = SnackBar(
                      content:
                          Text('Le numero de telephone n\'est pas valide !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  if (telephoneController.text[0] != "0") {
                    error = true;
                    const snackBar = SnackBar(
                      content:
                          Text('Le numero de téléphone doit commencer par 0 !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  if (firstnameController.text.contains(new RegExp(r'[0-9]'))) {
                    error = true;
                    const snackBar = SnackBar(
                      content:
                          Text('Le prenom ne doit pas contenir de chiffre !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  if (nameController.text.contains(new RegExp(r'[0-9]'))) {
                    error = true;
                    const snackBar = SnackBar(
                      content: Text('Le nom ne doit pas contenir de chiffre !'),
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

                  if (passwordController.text !=
                      confirmPasswordController.text) {
                    error = true;
                    const snackBar = SnackBar(
                      content: Text(
                          'La confirmation de mot de passe et le mot de passe ne sont pas identique !'),
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

                  if (nameController.text == "" ||
                      firstnameController.text == "" ||
                      usernameController.text == "" ||
                      telephoneController.text == "" ||
                      cityController.text == "" ||
                      adressController.text == "" ||
                      PostalCodeController.text == "" ||
                      passwordController.text == "" ||
                      emailController.text == "") {
                    error = true;
                    const snackBar = SnackBar(
                      content: Text('Des champs sont vides !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  if (error == false) {
                    createParticulierAwait(
                        firstnameController.text,
                        nameController.text,
                        passwordController.text,
                        emailController.text,
                        usernameController.text,
                        telephoneController.text,
                        cityController.text,
                        adressController.text,
                        PostalCodeController.text);
                  }
                  const snackBar = SnackBar(
                    content:
                        Text('Inscription réussi ! vous pouvez vous connecter'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  Future createParticulierAwait(firstname, name, password, email, username,
      phone, city, adress, postalCode) async {
    if (await ParticulierController.createParticulier(firstname, name, password,
            email, username, phone, city, adress, postalCode) ==
        200) {
      Navigator.of(context).pushNamed(SelectionPage.tag);
    }
  }
}
