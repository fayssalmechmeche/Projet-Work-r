import 'package:flutter/material.dart';
import 'package:my_app/Controller/Artisan/ArtisanController.dart';
import 'package:my_app/Controller/Particulier/ParticulierController.dart';
import 'package:my_app/Controller/global.dart';
import 'package:provider/provider.dart';

class DevisFollow extends StatefulWidget {
  const DevisFollow({Key? key}) : super(key: key);
  static const tag = "/DevisFollow";
  @override
  State<DevisFollow> createState() => _DevisFollowState();
}

class _DevisFollowState extends State<DevisFollow> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final globalData = Provider.of<GlobalData>(context);

    print(data['id']);

    final particulier = ParticulierController.getParticulierById(data['id']);
    print(particulier);

    // final artisan = ArtisanController.getArtisan(globalData.getId());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.backspace,
            color: Colors.red,
          ),
        ),
        title: const Text(
          "Devis reçus",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 45,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nom de l'artisan : "),
                  Text(
                    "testartisan",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text("Nom du particulier : "),
                  Text(
                    "testparticulier",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text("Catégorie de travaux : "),
                  Text(
                    "Plomberie",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text("Type de logement : "),
                  Text(
                    "Appartement",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text("Budget : "),
                  SizedBox(width: 10),
                  Text(
                    "10 000 €",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text("Photos / Plans : "),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: AssetImage('assets/photo1.jpg'),
                        radius: 20,
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text("Devis en PDF : "),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Télécharger",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (globalData.getRole() == 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Accepter",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                          ),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            // ParticulierController.refuseDevis(globalData.getId(), data['id'])
                          },
                          child: Text(
                            "Refuser",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
