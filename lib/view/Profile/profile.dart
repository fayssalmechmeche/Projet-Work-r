import 'package:flutter/material.dart';
import 'package:my_app/view/Profile/editprofile.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required String title}) : super(key: key);
  static const tag = "/Profile";
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Mon espace",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        toolbarHeight: 45,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(children: [
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
                    Text(globalData.getName() + "  " + globalData.getLastName(),
                        style: TextStyle(fontSize: 18)),
                    if (globalData.getRole() == 0)
                      Text(globalData.getEntreprise(),
                          style:
                              TextStyle(fontSize: 18, color: Colors.red[900])),
                  ]),
                )
              ])),
          Container(
              padding: const EdgeInsets.only(left: 45),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 10),
                      child: Text("Adresse", style: TextStyle(fontSize: 18)),
                    ),
                    Text(globalData.getAdress(),
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (globalData.getRole() == 1)
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 20, bottom: 10),
                                width: 210,
                                child: const Text("Ville",
                                    style: TextStyle(fontSize: 18)),
                              ),
                            if (globalData.getRole() == 1)
                              Text(globalData.getCity(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            if (globalData.getRole() == 0)
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 20, bottom: 10),
                                width: 210,
                                child: const Text("Mobilité",
                                    style: TextStyle(fontSize: 18)),
                              ),
                            if (globalData.getRole() == 0)
                              Text(globalData.getMobilite(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (globalData.getRole() == 0)
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                width: 120,
                                child: const Text("Domaine",
                                    style: TextStyle(fontSize: 18)),
                              ),
                            if (globalData.getRole() == 0)
                              Text(globalData.getDomaine(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            if (globalData.getRole() == 1)
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                width: 120,
                                child: const Text("Code Postale",
                                    style: TextStyle(fontSize: 18)),
                              ),
                            if (globalData.getRole() == 1)
                              Text(globalData.getPostalCode(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                          ]),
                    ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, bottom: 10),
                              width: 210,
                              child: const Text("Mail",
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Text(globalData.getEmail(),
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey)),
                          ]),
                      if (globalData.getRole() == 0)
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                width: 120,
                                child: const Text("Siret",
                                    style: TextStyle(fontSize: 18)),
                              ),
                              Text(globalData.getSiret(),
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ]),
                    ]),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child:
                          Text("Mot de passe", style: TextStyle(fontSize: 18)),
                    ),
                    const Text("**********",
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text("Téléphone", style: TextStyle(fontSize: 18)),
                    ),
                    Text(globalData.getPhone(),
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ])),
          Container(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 15, right: 15, left: 15),
              width: 160,
              height: 85,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProfile.tag);
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green)),
                child: const Text('Modification',
                    style: TextStyle(color: Colors.black)),
              )),
        ]),
      ),
    );
  }
}
