import 'package:flutter/material.dart';
import 'package:my_app/view/Profile/editprofile.dart';
import 'package:my_app/view/LunchPage/firstpage.dart';
import 'package:my_app/view/Home/homepage.dart';
import 'package:my_app/view/Login/login.dart';
import 'package:my_app/view/Navigation/navigationpage.dart';
import 'package:my_app/view/Register/registerartisant.dart';
import 'package:my_app/view/Register/registerselection.dart';
import 'package:my_app/view/Login/selectionPage.dart';
import 'package:my_app/view/Profile/profile.dart';
import 'package:my_app/view/Register/register.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const firstpage(title: "register",),
      routes: {
        login.tag: (context) => const login(title: "Login"),
        RegisterPage.tag: (context) => const RegisterPage(title: "register",),
        RegisterSelectionPage.tag: (context) => const RegisterSelectionPage(title: 'registerselection'),
        RegisterArtisan.tag: (context) => const RegisterArtisan(title: "registerartisant"),
        selectionPage.tag: (context) => const selectionPage(title: "Selection"),
        profile.tag: (context) => const profile(title: "profile"),
        editprofile.tag: (context) => const editprofile(),
        navigationpage.tag: (context) => const navigationpage(),
      },
    );
  }
}

