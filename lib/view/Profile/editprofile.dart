import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/view/Profile/profile.dart';
import '../../Controller/global.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);
  static const tag = "/EditProfile";
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var adresseController = TextEditingController();
  var cityController = TextEditingController();
  var postalCodeController = TextEditingController();
  var mailController = TextEditingController();
  var phoneController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var passwordController = TextEditingController();
  var entrepriseController = TextEditingController();
  var siretController = TextEditingController();
  var mobiliteController = TextEditingController();
  var domaineController = TextEditingController();

  late String _imageName;

  Future<void> _getImageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      String fileName = path.basename(_imageName);
      final newPath = '${directory.path}/$fileName';
      final newFile = await File(pickedFile.path).copy(newPath);
      setState(() {
        _imageName = newFile.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    final globalData = Provider.of<GlobalData>(context, listen: false);
    _imageName = globalData.getPicture();
    //print(_imageName);
  }

  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    var imagePicture = _imageName;
    adresseController.text = globalData.getAdress();
    mailController.text = globalData.getEmail();
    firstNameController.text = globalData.getName();
    lastNameController.text = globalData.getLastName();
    phoneController.text = globalData.getPhone();
    if (globalData.getRole() == 1) {
      cityController.text = globalData.getCity();
      postalCodeController.text = globalData.getPostalCode();
    }
    if (globalData.getRole() == 0) {
      entrepriseController.text = globalData.getEntreprise();
      siretController.text = globalData.getSiret();
      mobiliteController.text = globalData.getMobilite();
      domaineController.text = globalData.getDomaine();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              "Profile",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ]),
          Container(
              padding: const EdgeInsets.only(top: 30, left: 40),
              child: Row(children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _imageName != null
                          ? Image.asset(_imageName).image
                          : NetworkImage(
                              "https://avatars.githubusercontent.com/u/77855537?s=40&v=4"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  child: GestureDetector(
                    onTap: _getImageFromGallery,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black54,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  child: Column(children: [
                    Container(
                      width: 140,
                      height: 40,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        controller: firstNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            label: const Text("Prenom"),
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: 140,
                      height: 50,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        controller: lastNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            label: const Text("Nom"),
                            labelStyle: const TextStyle(color: Colors.grey)),
                      ),
                    ),
                  ]),
                )
              ])),
          Container(
            padding: const EdgeInsets.only(top: 40),
            width: 330,
            child: TextFormField(
              cursorColor: Colors.grey,
              controller: adresseController,
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
            if (globalData.getRole() == 1)
              Container(
                padding: const EdgeInsets.only(top: 20, right: 20),
                width: 210,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: cityController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      label: const Text("Ville"),
                      labelStyle: const TextStyle(color: Colors.grey)),
                ),
              ),
            if (globalData.getRole() == 0)
              Container(
                padding: const EdgeInsets.only(top: 20, right: 20),
                width: 210,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: mobiliteController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      label: const Text("Mobilité"),
                      labelStyle: const TextStyle(color: Colors.grey)),
                ),
              ),
            if (globalData.getRole() == 1)
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 120,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: postalCodeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      label: const Text("Code Postale"),
                      labelStyle: const TextStyle(color: Colors.grey)),
                ),
              ),
            if (globalData.getRole() == 0)
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 120,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: domaineController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      label: const Text("Domaine"),
                      labelStyle: const TextStyle(color: Colors.grey)),
                ),
              ),
          ]),
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: 330,
            child: TextFormField(
              cursorColor: Colors.grey,
              controller: mailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  label: const Text("Mail"),
                  labelStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: 330,
            child: TextFormField(
              cursorColor: Colors.grey,
              controller: phoneController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  label: const Text("Téléphone"),
                  labelStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: 330,
            child: TextFormField(
              cursorColor: Colors.grey,
              controller: passwordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  label: const Text("Mot de passe"),
                  labelStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 80, right: 15, left: 15),
              width: 160,
              height: 105,
              child: OutlinedButton(
                onPressed: () {
                  bool error = false;
                  bool emailValid =
                      RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                          .hasMatch(mailController.text);
                  if (emailValid == false) {
                    error = true;
                    const snackBar = SnackBar(
                      content: Text('Error in email!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  var passwordFinal;
                  if (passwordController.text == "" ||
                      passwordController.text == " ") {
                    passwordFinal = null;
                  } else {
                    passwordFinal = passwordController.text;
                  }

                  if (globalData.getRole() == 1 && error == false) {
                    ParticulierController.updateParticulier(
                      globalData.getId(),
                      firstNameController.text,
                      lastNameController.text,
                      passwordFinal,
                      mailController.text,
                      globalData.getUsername(),
                      phoneController.text,
                      cityController.text,
                      adresseController.text,
                      postalCodeController.text,
                      _imageName,
                    );
                    var user = {
                      '_id': globalData.getId(),
                      'name': firstNameController.text,
                      'lastname': lastNameController.text,
                      'password': passwordController.text,
                      'email': mailController.text,
                      'username': globalData.getUsername(),
                      'telephone': phoneController.text,
                      'city': cityController.text,
                      'adress': adresseController.text,
                      'postalCode': postalCodeController.text,
                      'picture': _imageName,
                      'chantier': 'n',
                    };

                    globalData.setUser(user, 1);
                    Navigator.pop(context);
                    const snackBar = SnackBar(
                      content: Text('Profile has been edited !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  if (globalData.getRole() == 0 && error == false) {
                    ArtisanController.updateArtisan(
                      globalData.getId(),
                      firstNameController.text,
                      lastNameController.text,
                      passwordFinal,
                      mailController.text,
                      globalData.getUsername(),
                      phoneController.text,
                      adresseController.text,
                      entrepriseController.text,
                    );
                    var user = {
                      '_id': globalData.getId(),
                      'name': firstNameController.text,
                      'lastname': lastNameController.text,
                      'email': mailController.text,
                      'username': globalData.getUsername(),
                      'telephone': phoneController.text,
                      'adress': adresseController.text,
                      'domaine': domaineController.text,
                      'entreprise': entrepriseController.text,
                      'mobilite': mobiliteController.text,
                      'siret': siretController.text,
                      'picture': 'n',
                      'chantier': 'n',
                    };

                    globalData.setUser(user, 0);
                    Navigator.pop(context);
                    const snackBar = SnackBar(
                      content: Text('Votre profil a été modifié !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green)),
                child: const Text('Sauvegarder',
                    style: TextStyle(color: Colors.black)),
              )),
        ]),
      ),
    );
  }
}
