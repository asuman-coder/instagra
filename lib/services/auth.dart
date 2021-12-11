import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagra/models/object.dart';
import 'package:instagra/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user object based on User
  Object _userFromUser(User user) {
    return user != null ? Object(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<Object> get user {
    return _auth.authStateChanges().map(_userFromUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;

      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      // create a new document  for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(
          'new displayName',
          'photoUrl ',
          'email',
          'new bio',
          'new username',
          'new userImage',
          'new userPost',
          'new caption');
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
