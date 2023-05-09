import 'package:flutter/material.dart';
import 'package:my_app/view/Home/homepage.dart';
import 'package:my_app/view/Home/listfav.dart';
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
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Controller/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    runApp(
      ChangeNotifierProvider(
        create: (context) => GlobalData(),
        child: MyApp(),
      ),
    );
  } catch (e) {
    print('Erreur lors de l\'initialisation de Firebase: $e');
    // Gérer l'erreur en conséquence
  }
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
      home: const FirstPage(title: 'Flutter Demo Home Page'),
      routes: {
        HomePage.tag: (context) => const HomePage(),
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
      },
    );
  }
}
