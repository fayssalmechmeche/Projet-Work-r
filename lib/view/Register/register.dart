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
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    var firstnameController = TextEditingController();
    var usernameController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var confirmPasswordController = TextEditingController();
    var phoneController = TextEditingController();
    var adressController = TextEditingController();
    var PostalCodeController = TextEditingController();
    var emailController = TextEditingController();
    var cityController = TextEditingController();

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(color: Colors.black),
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 10),
                                  width: 150,
                                  child: TextFormField(
                                    cursorColor: Colors.grey,
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(90),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(90),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        labelText: "Nom",
                                        labelStyle:
                                            TextStyle(color: Colors.grey)),
                                    validator: (String? val) {
                                      if (val!.isEmpty) {
                                        return "Nom manquant !";
                                      }
                                      if (val.contains(new RegExp(r'[;]'))) {
                                        return 'Invalide !';
                                      }

                                      if (val.contains(new RegExp(r'[0-9]'))) {
                                        return "Le nom n\'est pas valide !";
                                      }

                                      return null;
                                    },
                                  )),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 10),
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
                                      labelText: "Prénom",
                                      labelStyle:
                                          TextStyle(color: Colors.grey)),
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return "Prénom manquant !";
                                    }
                                    if (val.contains(new RegExp(r'[0-9]'))) {
                                      return "Le prénom n\'est pas valide !";
                                    }
                                    if (val.contains(new RegExp(r'[;]'))) {
                                      return 'Invalide !';
                                    }

                                    return null;
                                  },
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
                                  cursorColor: Colors.grey,
                                  controller: usernameController,
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
                                    labelText: "Nom d'utilisateur",
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return "Nom d'utilisateur manquant !";
                                    }
                                    if (val!.contains(new RegExp(
                                        r'[!@#$%^&*(),.?":{}|<>]'))) {
                                      return "Nom d'utilisateur n'est pas valide !";
                                    }
                                    if (val.contains(new RegExp(r'[;]'))) {
                                      return 'Invalide !';
                                    }

                                    return null;
                                  },
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
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    labelText: "Numéro de téléphone",
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return "Numéro de téléphone manquant !";
                                    }
                                    if (val!.length != 10) {
                                      return "Le numéro de téléphone n\'est pas valide !";
                                    }
                                    if (val.indexOf("0") != 0) {
                                      print(val.indexOf("0"));
                                      return "Le numéro de téléphone doit commencer par 0 !";
                                    }
                                    if (val.contains(new RegExp(r'[;]'))) {
                                      return 'Invalide !';
                                    }

                                    return null;
                                  },
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
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    labelText: "Adresse email",
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return "Adresse email manquante !";
                                    }
                                    if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                            .hasMatch(val) ==
                                        false) {
                                      return "L\'adresse email n\'est pas valide !";
                                    }
                                    if (val.contains(new RegExp(r'[;]'))) {
                                      return 'Invalide !';
                                    }

                                    return null;
                                  },
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
                                        borderRadius:
                                            BorderRadius.circular(90.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius:
                                            BorderRadius.circular(90.0),
                                      ),
                                      contentPadding: const EdgeInsets.all(10),
                                      label: const Text("Adresse"),
                                      labelStyle:
                                          const TextStyle(color: Colors.grey)),
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return "Adresse manquante !";
                                    }
                                    if (val.contains(new RegExp(
                                        r'[!@#$%^&*(),.?":{}|<>]'))) {
                                      return "Adresse n'est pas valide !";
                                    }
                                    if (val.contains(new RegExp(r'[;]'))) {
                                      return 'Invalide !';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 20, right: 10),
                                      width: 170,
                                      child: TextFormField(
                                        cursorColor: Colors.grey,
                                        controller: cityController,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(90.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(90.0),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            label: const Text("Ville"),
                                            labelStyle: const TextStyle(
                                                color: Colors.grey)),
                                        validator: (String? val) {
                                          if (val!.isEmpty) {
                                            return "Ville manquante !";
                                          }
                                          if (val!.contains(
                                                  new RegExp(r'[0-9]')) ||
                                              val.contains(new RegExp(
                                                  r'[!@#$%^&*(),.?":{}|<>]'))) {
                                            return "La ville n'est pas valide !";
                                          }
                                          if (val
                                              .contains(new RegExp(r'[;]'))) {
                                            return 'Invalide !';
                                          }

                                          return null;
                                        },
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
                                              borderRadius:
                                                  BorderRadius.circular(90.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(90.0),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            label: const Text("Code Postal"),
                                            labelStyle: const TextStyle(
                                                color: Colors.grey)),
                                        validator: (String? val) {
                                          if (val!.isEmpty) {
                                            return "Code postal manquant !";
                                          }
                                          if (val!.length != 5) {
                                            return "Le code postal n'est pas valide !";
                                          }
                                          if (val
                                              .contains(new RegExp(r'[;]'))) {
                                            return 'Invalide !';
                                          }

                                          return null;
                                        },
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
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    labelText: "Mot de passe",
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return "Mot de passe manquant !";
                                    }
                                    if (val.length < 8) {
                                      return 'Le mot de passe doit contenir au moins 8 caractères !';
                                    }
                                    if (val.contains(new RegExp(r'[a-z]')) ==
                                        false) {
                                      return 'Le mot de passe doit contenir au moins une minuscule !';
                                    }
                                    if (val.contains(new RegExp(r'[A-Z]')) ==
                                        false) {
                                      return 'Le mot de passe doit contenir au moins une majuscule !';
                                    }
                                    if (val.contains(new RegExp(r'[0-9]')) ==
                                        false) {
                                      return 'Le mot de passe doit contenir au moins un chiffre !';
                                    }
                                    if (val.contains(new RegExp(
                                            r'[!@#$%^&*(),.?":{}|<>]')) ==
                                        false) {
                                      return 'Le mot de passe doit contenir un caractère spécial !';
                                    }
                                    if (val.contains(new RegExp(r'[;]'))) {
                                      return 'Invalide !';
                                    }

                                    return null;
                                  },
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
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(90.0),
                                    ),
                                    contentPadding: const EdgeInsets.all(10),
                                    labelText: "Répeter mot de passe ",
                                    labelStyle: TextStyle(color: Colors.grey),
                                  ),
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return "Comfirmation du mot de passe manquante !";
                                    }
                                    if (val != passwordController.text) {
                                      return 'La confirmation du mot de passe et le mot de passe ne sont pas identiques !';
                                    }
                                    if (val.contains(new RegExp(r'[;]'))) {
                                      return 'Invalide !';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: 150,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        createParticulierAwait(
                            firstnameController.text,
                            nameController.text,
                            passwordController.text,
                            emailController.text,
                            usernameController.text,
                            phoneController.text,
                            cityController.text,
                            adressController.text,
                            PostalCodeController.text);

                        const snackBar = SnackBar(
                          content: Text(
                              'Inscription réussie ! Vous pouvez vous connecter'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.pop(context);
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
        ));
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
