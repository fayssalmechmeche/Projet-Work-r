import 'package:flutter/material.dart';
import 'package:my_app/view/Navigation/NavigationPage.dart';
import '../../Controller/NodeJSManager.dart';

class LoginArt extends StatefulWidget {
  const LoginArt({Key? key}) : super(key: key);
  static const tag = "/Loginart";
  @override
  _LoginArtState createState() => _LoginArtState();
}

class _LoginArtState extends State<LoginArt> {
  var visiblePassword = false;
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(children: <Widget>[
              Container(
                width: 150,
                height: 150,
                child: Image.asset("assets/logo.png"),
              ),
              Container(
                padding: const EdgeInsets.only(top: 80),
                width: 300,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    labelText: "Nom d'utilisateur",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30),
                width: 300,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: passwordController,
                  obscureText: !visiblePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                    labelText: "Mot de passe",
                    labelStyle: TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(visiblePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      color: Colors.yellow,
                      onPressed: () {
                        setState(() {
                          visiblePassword = !visiblePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: 150,
                  height: 65,
                  child: OutlinedButton(
                    onPressed: () async {

                      print(await NodeJSManager.authenticate(usernameController.text,
                          passwordController.text));
                      if (await NodeJSManager.authenticate(usernameController.text,
                              passwordController.text) == 200) {
                        Navigator.of(context).pushNamed(NavigationPage.tag);
                      };

                    },
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      foregroundColor: Colors.yellow,
                      backgroundColor: Colors.yellow.withOpacity(0.5),
                    ),
                    child: const Text('Connexion',
                        style: TextStyle(color: Colors.black)),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: GestureDetector(
                  onTap: () {
                    print('Text Clicked');
                  },
                  child: const Text('Mot de passe oublié ?'),
                ),
              )
            ]),
          ],
        ),
      ),
    
      
    );
  }
}