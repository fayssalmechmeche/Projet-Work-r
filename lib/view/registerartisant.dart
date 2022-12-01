import 'package:flutter/material.dart';

class RegisterArtisan extends StatefulWidget {
  const RegisterArtisan({Key? key, required String title}) : super(key: key);
  static const tag = "/registerartisant";
  @override
  _RegisterArtisanState createState() => _RegisterArtisanState();
}

class _RegisterArtisanState extends State<RegisterArtisan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.black),
        elevation: 0,
      ),
      
    );
  }
}