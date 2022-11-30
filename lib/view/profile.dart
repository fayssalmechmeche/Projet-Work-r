import 'package:flutter/material.dart';
class profile extends StatefulWidget {
  const profile({Key? key, required String title}) : super(key: key);
  static const tag = "/profile";
  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  var adresseController = TextEditingController();

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
              Text("Profile", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              ]
          ),
          Container(
              padding: const EdgeInsets.only( top: 40, left: 40),
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
                  padding: const EdgeInsets.only( left: 80),
                  child :
                    Column(
                        children: const [
                          Text("Jean-Paul"),
                          Text("Blabla")
                        ]
                    ),
                  )
                ]
              )
          ),
          Container(
            padding: const EdgeInsets.only(top: 80),
            width: 300,
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
                hintText: "Adresse",
              ),
            ),
          ),
        ]
      ),
      ),
    );
  }
}
