import 'package:flutter/material.dart';
import 'package:my_app/view/Login/loginart.dart';
import 'package:my_app/view/Msg/chat.dart';
import 'package:my_app/view/Profile/editprofile.dart';
import 'package:my_app/view/LunchPage/firstpage.dart';
import 'package:my_app/view/Login/login.dart';
import 'package:my_app/view/Navigation/NavigationPage.dart';
import 'package:my_app/view/Register/registerartisant.dart';
import 'package:my_app/view/Register/registerselection.dart';
import 'package:my_app/view/Login/SelectionPage.dart';
import 'package:my_app/view/Profile/profile.dart';
import 'package:my_app/view/Register/register.dart';
import 'package:my_app/view/Works/workfollow.dart';
import 'package:provider/provider.dart';

import 'Controller/global.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalData(),
      child: MyApp(),
    ),
  );
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
      home: const Login(),
      routes: {
        Login.tag: (context) => const Login(),
        LoginArt.tag: (context) => const LoginArt(),
        RegisterPage.tag: (context) => const RegisterPage(
              title: "register",
            ),
        RegisterSelectionPage.tag: (context) =>
            const RegisterSelectionPage(title: 'registerselection'),
        RegisterArtisan.tag: (context) =>
            const RegisterArtisan(title: "registerartisant"),
        SelectionPage.tag: (context) => const SelectionPage(),
        Profile.tag: (context) => const Profile(title: "profile"),
        EditProfile.tag: (context) => const EditProfile(),
        NavigationPage.tag: (context) => const NavigationPage(),
        Chat.tag: (context) => const Chat(),
        WorkFollow.tag: (context) => const WorkFollow(),
      },
    );
  }
}
