import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
import 'package:instagra/models/object.dart';
import 'package:instagra/models/post.dart';

class DatabaseService {
  final DateTime timestamp = DateTime.now();
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');
  Future updateUserData(
      String profileName,
      String url,
      String email,
      String bio,
      String username,
      String userImage,
      String postImage,
      String caption) async {
    return await postCollection.doc(uid).set({
      'profileName': profileName,
      'url': url,
      'email': email,
      'bio': bio,
      'username': username,
      'userImage': userImage,
      'postImage': postImage,
      'caption': caption,
      'timestamp': timestamp,
    });
    // user create username
    // if (! postCollection.doc(uid)){

    //  final username =await Navigator.push(context, MaterialPageRoute(builder: (context) =>Account()));
    // }
  }

  //post list from snapshot
  List<Post> _postListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Post(
        profileName: doc.data()['displayName'] ?? '',
        url: doc.data()['photoUrl'] ?? '',
        email: doc.data()['email'] ?? '',
        bio: doc.data()['bio'] ?? '',
        username: doc.data()['username'] ?? '',
        userImage: doc.data()['userImage'] ?? '',
        postImage: doc.data()['postImage'] ?? '',
        caption: doc.data()['caption'] ?? '',
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      profileName: snapshot.data()['displayName'],
      url: snapshot.data()['photoUrl'],
      email: snapshot.data()['email'],
      bio: snapshot.data()['bio'],
      username: snapshot.data()['username'],
      userImage: snapshot.data()['userImage'],
      postImage: snapshot.data()['postImage'],
      caption: snapshot.data()['caption'],
    );
  }

  //get posts stream
  Stream<List<Post>> get posts {
    return postCollection.snapshots().map(_postListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return postCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
