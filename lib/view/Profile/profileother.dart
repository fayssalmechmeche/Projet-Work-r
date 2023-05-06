import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';

class ProfileOther extends StatefulWidget {
  const ProfileOther({super.key});
  static const tag = "/ProfileOther";
  @override
  State<ProfileOther> createState() => _ProfileOtherState();
}

class _ProfileOtherState extends State<ProfileOther> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final globalData = Provider.of<GlobalData>(context);
    print(data);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Profile",
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
                        image: data["picture"] != "null"
                            ? Image.asset(data["picture"]).image
                            :  NetworkImage(
                                "https://avatars.githubusercontent.com/u/77855537?s=40&v=4"),
                        fit: BoxFit.fill),
                  ),
                ),
                Container(
                  width: 200,
                  padding: const EdgeInsets.only(left: 60),
                  child: Column(children: [
                    Text(data['name'] + "  " + data['lastname'],
                        style: TextStyle(fontSize: 18)),
                    
                      Text(data['entreprise'],
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
                    Text(data['adress'],
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                              Container(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 20, bottom: 10),
                                width: 210,
                                child: const Text("Mobilité",
                                    style: TextStyle(fontSize: 18)),
                              ),
                           
                              Text(data['mobilite'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                          ]),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                width: 120,
                                child: const Text("Domaine",
                                    style: TextStyle(fontSize: 18)),
                              ),
                            
                              Text(data['domaine'],
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
                                  top: 20, right: 20,),
                              width: 210,
                              child: const Text("Mail",
                                  style: TextStyle(fontSize: 18)),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 20, bottom: 10),
                              width: 210,
                              child: Text(data['email'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                                    
                            ),
                          ]),
                      
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
                              Text(data['siret'],
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.grey)),
                            ]),
                    ]),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text("Téléphone", style: TextStyle(fontSize: 18)),
                    ),
                    Text(data['telephone'],
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ])),
          Container(
              padding: const EdgeInsets.only(
                  top: 40, bottom: 15, right: 15, left: 15),
              width: 160,
              height: 85,
              child: OutlinedButton(
                onPressed: () {const snackBar = SnackBar(
            content: Text('Redirection vers discussion'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);},
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    foregroundColor: Colors.green,
                    side: const BorderSide(color: Colors.green)),
                child: const Text('Contacter',
                    style: TextStyle(color: Colors.black)),
              )),
        ]),
      ),
    );
  }
}
