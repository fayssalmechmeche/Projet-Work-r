import 'package:flutter/material.dart';
import 'package:my_app/view/editprofile.dart';
import 'package:my_app/view/firstpage.dart';
import 'package:my_app/view/homepage.dart';
import 'package:my_app/view/login.dart';
import 'package:my_app/view/navigationpage.dart';
import 'package:my_app/view/registerartisant.dart';
import 'package:my_app/view/registerselection.dart';
import 'package:my_app/view/selectionPage.dart';
import 'package:my_app/view/profile.dart';
import 'package:my_app/view/register.dart';
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

