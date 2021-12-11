import 'package:flutter/material.dart';
import 'package:instagra/models/post.dart';
import 'package:instagra/pages/add.dart';
import 'package:instagra/services/feed.dart';
import 'package:instagra/services/database.dart';
import 'package:provider/provider.dart';
//import 'package:instagra/pages/account.dart';
//import 'package:instagra/services/database.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // String username;
  // void updateUsername(index) {}

  // final username =await Navigator.push(context, MaterialPageRoute(builder: (context) =>Account()));

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Post>>.value(
      value: DatabaseService().posts,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          centerTitle: true,
          title: Text(
            'Instagram',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            tooltip: 'Take a picture',
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Add(),
                    fullscreenDialog: true,
                  ));
            },
            icon: Icon(Icons.camera_alt),
            color: Colors.black,
          ),
          actions: [
            // FlatButton.icon(
            //icon: Icon(Icons.person),
            //color: Colors.black,
            // label: Text('out'),
            // onPressed: () async {
            //  await _auth.signOut();
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.send_sharp),
              color: Colors.black,
            ),
          ],
        ),
        body: Feed(),
      ),
    );
  }
}
