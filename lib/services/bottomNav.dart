import 'package:flutter/material.dart';
import 'package:instagra/pages/account.dart';
import 'package:instagra/pages/add.dart';
import 'package:instagra/pages/browse.dart';
import 'package:instagra/pages/home.dart';
import 'package:instagra/pages/notifications.dart';
//import 'package:instag/models/bottom_nav_model.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static List<Widget> _bottomNavView = [
    Home(),
    Browse(),
    Add(),
    Notifications(),
    Account(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _bottomNavView.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: ('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: ('Add'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: ('Notifications'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity),
            label: ('Account'),
          ),
        ],
      ),
    );
  }
}
