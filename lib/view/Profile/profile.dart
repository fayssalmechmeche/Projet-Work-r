import 'package:flutter/material.dart';
import 'package:my_app/view/Profile/editprofile.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';
import '../LunchPage/firstpage.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
  return const FirstPage(title: '',);
}), (r){
  return false;
});
          },
          icon: Icon(
            Icons.logout,
            color: Colors.red,
          ),
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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: globalData.getPicture() != "null"
                            ? NetworkImage(globalData.getPicture())
                            : NetworkImage(
                                "https://avatars.githubusercontent.com/u/77855537?s=40&v=4"),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  width: 200,
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
              SizedBox(
              height: 454,
              child: ListView(shrinkWrap: true, children: [
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
                            Container(
                              padding:
                                  const EdgeInsets.only(right: 20, bottom: 10),
                              width: 210,
                              child: Text(globalData.getEmail(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ),
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
                    
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text("Téléphone", style: TextStyle(fontSize: 18)),
                    ),
                    Text(globalData.getPhone(),
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ])),
              ])),
          Container(
              padding: const EdgeInsets.only(
                  top: 20, bottom: 15, right: 15, left: 15),
              width: 160,
              height: 65,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProfile.tag)
                      .then((_) => setState(() {}));
                },
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    foregroundColor: Colors.green,
                    backgroundColor: Colors.green.withOpacity(0.75),
                    side: const BorderSide(color: Colors.green)),
                child: const Text('Modification',
                    style: TextStyle(color: Colors.white)),
              )),
        ]),
      ),
    );
  }
}
