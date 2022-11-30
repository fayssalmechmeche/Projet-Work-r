import 'package:flutter/material.dart';
import 'package:my_app/view/firstpage.dart';
import 'package:my_app/view/login.dart';
import 'package:my_app/view/selectionPage.dart';
import 'package:my_app/view/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const firstpage(title: 'Flutter Demo Home Page'),
      routes: {
        login.tag: (context) => const login(title: "Login"),
        selectionPage.tag: (context) => const selectionPage(title: "Selection"),
        profile.tag: (context) => const profile(title: "profile"),
      },
    );
  }
}

