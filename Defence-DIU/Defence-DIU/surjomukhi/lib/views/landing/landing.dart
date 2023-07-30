import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:surjomukhi/config/config.dart';
import 'components/nav_items.dart';
import 'components/nav_pages.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getValueFromSharedPreferences();
  }

  Future<void> _getValueFromSharedPreferences() async {
    // Get an instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Get the value associated with "myKey". If it doesn't exist, return an empty string.
    String idvalue = prefs.getString('userStudentId') ?? "";
    String passvalue = prefs.getString('UserStudentPass') ?? "";
    String namevalue = prefs.getString('userStudentName') ?? "";
    String currentUservalue = prefs.getString('currentUserId') ?? "";

    setState(() {
      userStudentName = namevalue;
      userStudentId = idvalue;
      userStudentPass = passvalue;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          fixedColor: Colors.orangeAccent,
          currentIndex: _currentIndex,
          onTap: (int newIndex) => setState(() {
            _currentIndex = newIndex;
          }),
          items: navItems,
        ),
      );
}
