import 'package:flutter/material.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/view/Profile/profile.dart';
import '../../Controller/global.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    adresseController.text = globalData.getAdress();
    mailController.text = globalData.getEmail();
    phoneController.text = globalData.getPhone();
    cityController.text = globalData.getCity();
    postalCodeController.text = globalData.getPostalCode();
    firstNameController.text = globalData.getName();
    lastNameController.text = globalData.getLastName();

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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1669178082499-341906b2ab28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8dG93SlpGc2twR2d8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60"),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 60),
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
            )
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
                  if (globalData.getRole() == 1) {
                    ParticulierController.updateParticulier(
                      globalData.getId(),
                      firstNameController.text,
                      lastNameController.text,
                      passwordController.text,
                      mailController.text,
                      globalData.getUsername(),
                      phoneController.text,
                      cityController.text,
                      adresseController.text,
                      postalCodeController.text,
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
                      'picture': 'n',
                      'chantier': 'n',
                    };

                    globalData.setUser(user, 1);
                    Navigator.of(context).pushNamed(Profile.tag);
                    const snackBar = SnackBar(
                      content: Text('Profile has been edited !'),
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
