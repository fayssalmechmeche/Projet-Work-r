import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:my_app/view/profile.dart';
import 'package:my_app/view/workfollow.dart';
import 'package:my_app/view/chat.dart';
import 'package:my_app/view/homepage.dart';
import 'package:my_app/view/map.dart';
class navigationpage extends StatefulWidget {
  const navigationpage({Key? key}) : super(key: key);
  static const tag = "/nav";
  @override
  State<navigationpage> createState() => _navigationpageState();
}

class _navigationpageState extends State<navigationpage> {
  int _selectedIndex = 2;
  static final List<Widget> _NavScreens = <Widget> [
    chat(),
    map(),
    homepage(title: "home"),
    workfollow(),
    profile(title: "profile"),


  ];
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
        body:  Center(child: _NavScreens.elementAt(_selectedIndex)),
        bottomNavigationBar:
        GNav(
          gap: 8,
          tabBackgroundColor: Colors.yellow.withOpacity(0.5),
          tabs: const [
            GButton(icon: Icons.chat_bubble_outline),
            GButton(icon: Icons.location_on_outlined),
            GButton(icon: Icons.home_filled),
            GButton(icon: Icons.list_alt),
            GButton(icon: Icons.account_circle),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index){
            setState(() {
              _selectedIndex = index;
            });
          },
        )
    );
  }
}
