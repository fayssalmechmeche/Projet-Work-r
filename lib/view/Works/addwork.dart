import 'package:flutter/material.dart';

class AddWork extends StatefulWidget {
  const AddWork({Key? key}) : super(key: key);
  static const tag = "/AddWork";

  @override
  State<AddWork> createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  var adresseController = TextEditingController();
  var villeController = TextEditingController();
  var codePostaleController = TextEditingController();
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  String? _dropdownvalue1;
  List<String> hometype = [
    'Maison',
    'Appartement',
  ];
  String? _dropdownvalue2;
  List<String> category = ['Electricité', 'Plomberie', 'Maçonnerie'];

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.only(top: 40),
            width: 330,
            child: DropdownButtonFormField<String?>(
              hint: const Text('Type de logement'),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30.0),
                  ),
                ),
                contentPadding: const EdgeInsets.all(2),
              ),
              items: hometype.map((value) {
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
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: 330,
            child: DropdownButtonFormField<String?>(
              hint: const Text('Categorie'),
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
              value: _dropdownvalue2,
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownvalue2 = newValue;
                });
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
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
                  label: const Text("Budget"),
                  labelStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: []),
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
                  contentPadding: const EdgeInsets.all(100),
                  label: const Text("Description"),
                  labelStyle: const TextStyle(color: Colors.grey)),
            ),
          ),
          Container(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 15, right: 15, left: 15),
              width: 160,
              height: 85,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green)),
                child: const Text('Accepter',
                    style: TextStyle(color: Colors.black)),
              )),
        ]),
      ),
    );
  }
}
