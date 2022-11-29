import 'package:flutter/material.dart';
class login extends StatefulWidget {
  const login({Key? key, required String title}) : super(key: key);
  static const tag = "/login";
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var visiblePassword = false;
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(
              color: Colors.black
          ),
          elevation: 0,
        ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
                children: <Widget>[
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          labelText: "Nom d'utilisateur",
                          icon: Icon(Icons.account_box)),
                    ),
                  ),
                  SizedBox(
                      width: 300,
                      child:TextFormField(
                              controller: passwordController,
                              obscureText: !visiblePassword,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                labelText: "Mot de passe",
                                icon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(visiblePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  color: Theme.of(context).primaryColorDark,
                                  onPressed: () {
                                    setState(() {
                                      visiblePassword = !visiblePassword;
                                    });
                                  },
                                ),
                              ),
                            ),
                           ),
                ]
            ),
          ],
        ),
      ),
    );
  }
}
