import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagra/models/object.dart';
//import 'package:instagra/models/object.dart';
import 'package:instagra/shared/header.dart';
import 'package:instagra/shared/progress.dart';
import 'package:provider/provider.dart';
import 'package:instagra/services/database.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;
  updateUsername() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      // welcoming user
      var snackBar = new SnackBar(
        content: Text('welcome' + username),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Timer(Duration(seconds: 4), () {
        Navigator.pop(context, username);
      });
    }
  }

  // @override
  // void initState() {
  //  super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Object>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Scaffold(
              key: _scaffoldKey,
              appBar: header(
                context,
                strTitle: 'settings',
                disappearedBackButton: true,
              ),
              body: ListView(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 26.0),
                          child: Center(
                            child: Text(
                              userData.username,
                              style: TextStyle(
                                fontSize: 26.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Container(
                            child: Form(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.always,
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                validator: (val) {
                                  if (val.trim().length < 5 || val.isEmpty) {
                                    return 'user name is very short.';
                                  } else if (val.trim().length > 15) {
                                    return 'user name is very long.';
                                  } else {
                                    return null;
                                  }
                                },
                                onSaved: (val) => username = val,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: userData.username,
                                  labelStyle: TextStyle(fontSize: 16.0),
                                  hintText: 'must be atleast 5 characters',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: updateUsername,
                          child: Container(
                            height: 55.0,
                            width: 360.0,
                            decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                'Proceed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return circularProgress();
          }
        });
  }
}
