import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_app/view/Home/homepageart.dart';
import 'package:my_app/view/Profile/profile.dart';
import 'package:my_app/view/Works/listwork.dart';
import 'package:my_app/view/Msg/listchat.dart';
import 'package:my_app/view/Home/homepage.dart';
import 'package:my_app/view/ListDevis/ListProduction.dart';
import 'package:provider/provider.dart';

import '../../Controller/global.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);
  static const tag = "/nav";
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 2;
  static final List<Widget> _NavScreens = <Widget>[
    ListChat(),
    ListProposition(),
    const HomePage(),
    ListWork(),
    Profile(title: "profile"),
  ];
  static final List<Widget> _NavScreens2 = <Widget>[
    ListChat(),
    ListProposition(),
    HomePageArt(),
    ListWork(),
    Profile(title: "profile"),
  ];
  @override
  Widget build(BuildContext context) {
     final globalData = Provider.of<GlobalData>(context);
    return Scaffold(
      
        body: Center(child: (globalData.getRole() == 1) ? _NavScreens.elementAt(_selectedIndex) : _NavScreens2.elementAt(_selectedIndex)),
        bottomNavigationBar: GNav(
          gap: 8,
          tabBackgroundColor: Colors.yellow.withOpacity(0.5),
          tabs: const [
            GButton(icon: Icons.chat_bubble_outline),
            GButton(icon: Icons.insert_drive_file),
            GButton(icon: Icons.home_filled),
            GButton(icon: Icons.list_alt),
            GButton(icon: Icons.account_circle),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ));
  }
}
