import 'package:flutter/material.dart';
import 'package:my_app/login.dart';
import 'package:my_app/selectionPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        login.tag: (context) => const login(title: "Login"),
        selectionPage.tag: (context) => const selectionPage(title: "Selection"),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 40),
                        width: 200,
                        height: 200,
                        child:  Image.asset("assets/logo.png"),
                      ),
                  const Padding(padding:EdgeInsets.only(top: 80) ,child: Text("Prenez soin de chez vous depuis votre mobile.", style: TextStyle(fontSize: 12),)),
                  Container(
                      padding: const EdgeInsets.only(top: 20),
                      width: 220,
                      child: OutlinedButton(
                        onPressed: () {Navigator.of(context).pushNamed(selectionPage.tag);},
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          foregroundColor: Colors.yellow,
                        ),
                        child: const Text('Connexion', style: TextStyle(color: Colors.black)),
                      )
                  ),
                  Container(
                      padding: const EdgeInsets.only(top: 10),
                      width: 220,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: const StadiumBorder(),
                          foregroundColor: Colors.yellow,
                        ),
                        child: const Text('Inscription',style: TextStyle(color: Colors.black)),
                      )
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    width: 350,
                    height: 330,
                    child:  Image.asset("assets/ouvrier.png"),
                  ),
                ]
              ),
            ],
          ),
        ),
      );
  }
}
