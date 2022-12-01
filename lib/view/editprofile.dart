import 'package:flutter/material.dart';
class editprofile extends StatefulWidget {
  const editprofile({Key? key}) : super(key: key);
  static const tag = "/editprofile";
  @override
  State<editprofile> createState() => _editprofileState();
}

class _editprofileState extends State<editprofile> {
  var adresseController = TextEditingController();
  var villeController = TextEditingController();
  var codePostaleController = TextEditingController();
  var mailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const BackButton(
            color: Colors.black
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Profile", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                  ]
              ),
              Container(
                  padding: const EdgeInsets.only( top: 30, left: 40),
                  child :
                  Row(
                      children:  [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage("https://images.unsplash.com/photo-1669178082499-341906b2ab28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHx0b3BpYy1mZWVkfDN8dG93SlpGc2twR2d8fGVufDB8fHx8&auto=format&fit=crop&w=800&q=60"),
                                fit: BoxFit.fill
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only( left: 60),
                          child :
                          Column(
                              children: const [
                                Text("Jean-Paul", style: TextStyle(fontSize: 18)),
                                Text("Blabla", style: TextStyle(fontSize: 18))
                              ]
                          ),
                        )
                      ]
                  )
              ),
              Container(
                padding: const EdgeInsets.only(top: 40),
                width: 330,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: adresseController,
                  decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      label: const Text("Adresse"),
                      labelStyle: const TextStyle(color: Colors.grey)
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Container(
                      padding: const EdgeInsets.only(top: 20, right: 20),
                      width: 210,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        controller: villeController,
                        decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            label: const Text("Ville"),
                            labelStyle: const TextStyle(color: Colors.grey)
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: 120,
                      child: TextFormField(
                        cursorColor: Colors.grey,
                        controller: codePostaleController,
                        decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            contentPadding: const EdgeInsets.all(10),
                            label: const Text("Code Postale"),
                            labelStyle: const TextStyle(color: Colors.grey)
                        ),
                      ),
                    )
                  ]
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 330,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: mailController,
                  decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      label: const Text("Mail"),
                      labelStyle: const TextStyle(color: Colors.grey)
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 330,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: passwordController,
                  decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      label: const Text("Mot de passe"),
                      labelStyle: const TextStyle(color: Colors.grey)
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                width: 330,
                child: TextFormField(
                  cursorColor: Colors.grey,
                  controller: phoneController,
                  decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      label: const Text("Téléphone"),
                      labelStyle: const TextStyle(color: Colors.grey)

                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 40,bottom: 15, right: 15,left: 15),
                  width: 160,
                  height: 85,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        foregroundColor: Colors.green,
                        side: const BorderSide(color: Colors.green)

                    ),
                    child: const Text('Sauvegarder', style: TextStyle(color: Colors.black)),
                  )
              ),
            ]
        ),
      ),

    );
  }
}
