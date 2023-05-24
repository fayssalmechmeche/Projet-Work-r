import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_app/view/Home/homepage.dart';
import 'package:my_app/view/Home/listfav.dart';
import 'package:my_app/view/Home/search.dart';
import 'package:my_app/view/Home/homepageart.dart';
import 'package:my_app/view/ListDevis/ListProduction.dart';
import 'package:my_app/view/ListDevis/adddevis.dart';
import 'package:my_app/view/ListDevis/devis.dart';
import 'package:my_app/view/ListDevis/pdfdevis.dart';
import 'package:my_app/view/Login/loginart.dart';
import 'package:my_app/view/Msg/chat.dart';
import 'package:my_app/view/Profile/editprofile.dart';
import 'package:my_app/view/LunchPage/firstpage.dart';
import 'package:my_app/view/Login/login.dart';
import 'package:my_app/view/Navigation/NavigationPage.dart';
import 'package:my_app/view/Profile/profileother.dart';
import 'package:my_app/view/Register/registerartisant.dart';
import 'package:my_app/view/Register/registerselection.dart';
import 'package:my_app/view/Login/SelectionPage.dart';
import 'package:my_app/view/Profile/profile.dart';
import 'package:my_app/view/Register/register.dart';
import 'package:my_app/view/Task/addtask.dart';
import 'package:my_app/view/Task/listtasks.dart';
import 'package:my_app/view/Task/task.dart';
import 'package:my_app/view/Task/taskedit.dart';
import 'package:my_app/view/Works/addwork.dart';
import 'package:my_app/view/Works/workfollow.dart';
import 'package:my_app/view/Works/listworkartisan.dart';
import 'package:my_app/view/Works/workproposition.dart';
import 'package:my_app/view/NoInternetPage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Controller/MessageProvider.dart';
import 'firebase_options.dart';
import 'Controller/global.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MessageProvider()),
          ChangeNotifierProvider(create: (context) => GlobalData()),
          // ...
        ],
        child: MyApp(),
      ),
    );
  } catch (e) {
    print('Erreur lors de l\'initialisation de Firebase: $e');
    // Gérer l'erreur en conséquence
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late IO.Socket socket;

  late ConnectivityResult _connectivityResult;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result;
      });
    });
    Connectivity().checkConnectivity().then((result) {
      setState(() {
        _connectivityResult = result;
      });
    });
    // Initialisation du socket
    socket = IO.io(
        dotenv.env['DB_HOST']!,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());

    // Connect to websocket
    socket.connect();
  }

  @override
  void dispose() {
    socket.dispose(); 
    _connectivitySubscription.cancel();// Déconnecte et libère les ressources du socket
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalData>(context);
    globalData.setSocket(socket);
    print('socket: ${globalData.getSocket()}');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _buildHomePage(),
      routes: {
        HomePage.tag: (context) => HomePage(),
        Login.tag: (context) => const Login(),
        LoginArt.tag: (context) => const LoginArt(),
        RegisterPage.tag: (context) => const RegisterPage(
              title: "register",
            ),
        RegisterSelectionPage.tag: (context) => const RegisterSelectionPage(),
        RegisterArtisan.tag: (context) =>
            const RegisterArtisan(title: "registerartisant"),
        SelectionPage.tag: (context) => const SelectionPage(),
        Profile.tag: (context) => const Profile(title: "profile"),
        EditProfile.tag: (context) => const EditProfile(),
        NavigationPage.tag: (context) => const NavigationPage(),
        Chat.tag: (context) => const Chat(),
        WorkFollow.tag: (context) => const WorkFollow(),
        AddWork.tag: (context) => const AddWork(),
        DevisFollow.tag: (context) => const DevisFollow(),
        ListWorkArtisan.tag: (context) => const ListWorkArtisan(),
        WorkProposition.tag: (context) => const WorkProposition(),
        AddDevis.tag: (context) => const AddDevis(),
        AddTask.tag: (context) => const AddTask(),
        Task.tag: (context) => const Task(),
        TaskEdit.tag: (context) => const TaskEdit(),
        ListTasks.tag: (context) => const ListTasks(),
        ListFav.tag: (context) => const ListFav(),
        ProfileOther.tag: (context) => const ProfileOther(),
        Search.tag: (context) => const Search(),
        HomePageArt.tag: (context) => const HomePageArt(),
        ListProposition.tag: (context) => const ListProposition(),
      },
    );
  }
  Widget _buildHomePage() {
    if (_connectivityResult == ConnectivityResult.none) {
      return NoInternetPage(
        onRefresh: () {
          Connectivity().checkConnectivity().then((result) {
            setState(() {
              _connectivityResult = result;
            });
          });
        },
      );
    } else {
      // Retourne votre page d'accueil normale ici
      return FirstPage(title: '',);
    }
  }
}
