import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagra/shared/progress.dart';
import 'package:instagra/services/userResult.dart';

class Browse extends StatefulWidget {
  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse>
  with AutomaticKeepAliveClientMixin<Browse> {
     // bool get wantKeepAlive => true; 
  TextEditingController searchTextEditingController = TextEditingController();
  Future<QuerySnapshot> futureSearchResults;
  //clear the textFormField
  emptyTheTextFormField() {
    searchTextEditingController.clear();
  }

  controlSearching(String str) {
    Future<QuerySnapshot> allUsers = usersReference
        .where("profileName", isGreaterThanOrEqualTo: str)
        .getDocuments();
    setState(() {
      futureSearchResults = allUsers;
    });
  }

  // return appbar
  AppBar browseHeader() {
    return AppBar(
      backgroundColor: Colors.black,
      title: TextFormField(
        style: TextStyle(fontSize: 18.0, color: Colors.white),
        controller: searchTextEditingController,
        decoration: InputDecoration(
          hintText: 'Search here....',
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          filled: true,
          prefixIcon: Icon(
            Icons.person_pin,
            color: Colors.white,
            size: 30.0,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
            onPressed: emptyTheTextFormField,
          ),
        ),
        //submission
        onFieldSubmitted: controlSearching,
      ),
    );
  }

  Container displayNoSearchResultScreen() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Icon(
              Icons.group,
              color: Colors.grey,
              size: 200.0,
            ),
            Text(
              "Search Users",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 65.0),
            ),
          ],
        ),
      ),
    );
  }

  displayUsersFoundScreen() 
  {
    return FutureBuilder(
      future: futureSearchResults,
      builder: (context, dataSnapshot)
       {
        if (!dataSnapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> searchUsersResult = [];
        dataSnapshot.data.documents.forEach((document) 
        {
          User eachUser = User.fromDocument(document);
          UserResult userResult = UserResult(eachUser);
          searchUsersResult.add(userResult);
        });
        return ListView(children: searchUsersResult); 
      },
    );
  }
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: browseHeader(),
      body: futureSearchResults == null
          ? displayNoSearchResultScreen()
          : displayUsersFoundScreen(),
    );
  }
}

//UserResult class
//class UserResult extends StatelessWidget {
//final User eachUser;
// UserResult(this.eachUser);
// @override
// Widget build(BuildContext context) {
//  return Padding(
//   padding: EdgeInsets.all(3.0),
//  child: Container(
//  color: Colors.white54,
// child: Column(
//  children: <Widget>[
//   GestureDetector(
//   onTap: () => print("tapped"),
//  child: ListTile(
//  leading: CircleAvatar(
//   backgroundColor: Colors.black,
//  backgroundImage:
//     CachedNetworkImageProvider(eachUser.photoURL),
// ),
// title: Text(
//  eachUser.displayName,
// style: TextStyle(
//   color: Colors.black,
//   fontSize: 16.0,
//  fontWeight: FontWeight.bold,
// ),
// ),
//  subtitle: Text(
//   eachUser.username,
//   style: TextStyle(
//     color: Colors.black,
//    fontSize: 13.0,
//   ),
// ),
// ),
//  ),
// ],
// ),
//),
// );
// }
//}
