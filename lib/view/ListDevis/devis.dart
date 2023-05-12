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

    var particulierID = int.tryParse(data['particulierID']);
    var artisanID = int.tryParse(data['artisanID']);
    final particulier =
        ParticulierController.getParticulierById(particulierID!);
    final artisan = ArtisanController.getArtisanById(artisanID!);

    // final artisan = ArtisanController.getArtisan(globalData.getId());

    return SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
      future: particulier,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final particulier = snapshot.data![0];
          final artisan = snapshot.data![1];
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
                          "lol",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text("Nom du particulier : "),
                        Text(
                          snapshot.data!['results'][0]['lastname'] +
                              " " +
                              snapshot.data!['results'][0]['name'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text("Catégorie de travaux : "),
                        Text(
                          data["category"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text("Type de logement : "),
                        Text(
                          data["type"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text("Budget : "),
                        SizedBox(width: 10),
                        Text(
                          data["price"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text("Description : "),
                        SizedBox(height: 10),
                        // Row(
                        //   children: [
                        //     SizedBox(width: 10),
                        //     CircleAvatar(
                        //       backgroundColor: Colors.grey,
                        //       backgroundImage: AssetImage('assets/photo1.jpg'),
                        //       radius: 20,
                        //     ),
                        //     SizedBox(width: 10),
                        //     CircleAvatar(
                        //       backgroundColor: Colors.grey,
                        //       radius: 20,
                        //     ),
                        //     SizedBox(width: 10),
                        //     CircleAvatar(
                        //       backgroundColor: Colors.grey,
                        //       radius: 20,
                        //     ),
                        //   ],
                        // ),
                        Text(
                          data["description"],
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                        if (globalData.getRole() == 1 && data["state"] < 3)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  final response =
                                      await ParticulierController.accepteDevis(
                                          int.tryParse(data['particulierID'])!,
                                          data['id'],
                                          int.tryParse(data['workID'])!,
                                          int.tryParse(data['artisanID'])!);

                                  if (response["success"] == true) {
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(response["msg"]),
                                    ));
                                  }
                                },
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
                                onPressed: () async {
                                  final response =
                                      await ParticulierController.refuseDevis(
                                          int.tryParse(data['particulierID'])!,
                                          data['id']);

                                  if (response["success"] == true) {
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(response["msg"]),
                                    ));
                                  }
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
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
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
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    ));
  }
}
