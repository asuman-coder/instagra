import 'package:flutter/material.dart';
import 'package:instagra/authenticate/authenticate.dart';
//import 'package:instag/pages/home.dart';

import 'package:instagra/services/bottomNav.dart';

import 'package:provider/provider.dart';
import 'package:instagra/models/object.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Object>(context);
    print(user);
    // return either Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return BottomNav();
    }
  }
}
