import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../Controller/global.dart';

class AddDevis extends StatefulWidget {
  const AddDevis({super.key});
  static const tag = "/AddDevis";
  @override
  State<AddDevis> createState() => _AddDevisState();
}

class _AddDevisState extends State<AddDevis> {
  var nameController = TextEditingController();
  var budgetController = TextEditingController();
  var descriptionController = TextEditingController();
  String? _dropdownvalue1;
  List<String> hometype = [
    'Maison',
    'Appartement',
  ];
  String? _dropdownvalue2;
  List<String> category = ['Electricité', 'Plomberie', 'Maçonnerie'];

  PlatformFile? file;
  UploadTask? uploadTask;
  var fileName = 'aucun pdf';
  Future selectFile() async {
    PermissionStatus status = await Permission.storage.request();
    final resultFile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (resultFile == null) {
      return;
    }

    setState(() {
      file = resultFile.files.first;
    });
  }

  Future uploadFile() async {
    final uuid = Uuid();
    final uniqueId = uuid.v4();
    fileName = 'pdf_$uniqueId.pdf';
    final path = 'pdf/${fileName}';
    final firebaseFile = File(file!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(firebaseFile);
    final snap = await uploadTask!.whenComplete(() {});
    final urlDownload = await snap.ref.getDownloadURL();
    print('Download-Link: $urlDownload');

    setState(() {
      uploadTask = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final globalData = Provider.of<GlobalData>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Text(
              "Nouveau devis",
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
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  side: const BorderSide(width: 1, color: Colors.grey),
                  foregroundColor: Colors.yellow,
                ),
                onPressed: selectFile,
                child: const Text(
                  '+ Ajouter un devis format PDF +',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              )),
          Text(
            'Fichier PDF sélectionné : ${file?.name ?? "Aucun fichier sélectionné"}',
            style: const TextStyle(color: Colors.grey),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: 330,
            child: TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              cursorColor: Colors.grey,
              controller: budgetController,
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
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: 330,
            child: TextFormField(
              minLines: 1,
              maxLines: 7,
              cursorColor: Colors.grey,
              controller: descriptionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(9.0),
                  ),
                  contentPadding: const EdgeInsets.all(10),
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
                onPressed: () {
                  bool error = false;
                  if (budgetController.text == "" ||
                      descriptionController.text == "" ||
                      _dropdownvalue1 == null ||
                      _dropdownvalue2 == null) {
                    error = true;
                  }
                  if (error == false) {
                    print(fileName);
                    //AddDevisToBdd

                    if (file != null) {
                      uploadFile();
                      ArtisanController.createDevis(
                          globalData.getId(),
                          data['particulierID'],
                          data['id'],
                          _dropdownvalue1,
                          _dropdownvalue2,
                          budgetController.text,
                          descriptionController.text,
                          fileName);
                      const snackBar = SnackBar(
                        content: Text('Devis envoyé !'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.of(context)
                        ..pop()
                        ..pop();
                    } else {
                      const snackBar = SnackBar(
                        content:
                            Text('Attention à bien ajouter un devis en pdf !'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }

                    //UploadFile
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Attention à bien remplir le formulaire !'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    foregroundColor: Colors.green,
                    backgroundColor: Colors.green.withOpacity(0.75),
                    side: const BorderSide(color: Colors.green)),
                child: const Text('Confirmer',
                    style: TextStyle(color: Colors.white)),
              ))
        ]),
      ),
    );
  }
}
