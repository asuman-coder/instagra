import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:instag/services/bottomNav.dart';
import 'package:instagra/wrapper.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // enhance loading of the app to homepage
  startTime() async {
    return Timer(Duration(milliseconds: 4500), _navigatorPage);
  }

// return homepage
  void _navigatorPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Wrapper();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTime();
    // for navigation to homepage or homescreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            //distace from top
            SizedBox(height: 200),
            Center(
              child: Image.asset(
                'assets/insta_logo.png',
                fit: BoxFit.fill,
                width: 100,
              ),
            ),
            // spacer from insta logo
            Spacer(),
            Text(
              'FROM',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            // distance from upper text
            SizedBox(height: 12.0),
            Text(
              'FLUTTER WORLD',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.pinkAccent,
              ),
            ),
            // distance from bottom of the page
            SizedBox(height: 80.0),
          ],
        ),
      ),
    );
  }
}
