import 'package:firebase_core/firebase_core.dart'; // connect firebase default app
import 'package:flutter/material.dart';
import 'package:instagra/pages/splash.dart';
//import 'package:instag/authenticate/register.dart';
//import 'package:instag/authenticate/sign_in.dart';
import 'package:instagra/services/auth.dart';
import 'package:instagra/services/bottomNav.dart';
import 'package:instagra/wrapper.dart';
//import 'package:instag/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:instagra/models/object.dart';

void main() async {
  // connect the initialized firebase app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Object>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Instagram',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/wrapper': (context) => Wrapper(),
          '/bottomNav': (context) => BottomNav(),
        },
      ),
    );
  }
}
