import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:techno_vile_blog/models/user_models.dart';
import 'package:techno_vile_blog/services/database.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  UserModels _userFromFirebaseuser(User user) {
    return user != null ? UserModels(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModels> get user {
    return _auth.authStateChanges().map(_userFromFirebaseuser);
  }

  //sign in anon
  Future anonSingin() async {
    try {
      UserCredential results = await _auth.signInAnonymously();
      User user = results.user;
      return _userFromFirebaseuser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and pwd
  Future signInUser(String email, String pwd) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      User user = result.user;
      return _userFromFirebaseuser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and pwd
  Future registerUser(String email, String pwd) async {
    try {
      UserCredential results = await _auth.createUserWithEmailAndPassword(
          email: email, password: pwd);
      User user = results.user;
      await DatabaseService(uid: user.uid)
          .updateUserData("firstName", "lastName");
      return _userFromFirebaseuser(user);
    } catch (signUpError) {
      if (signUpError is PlatformException) {
        if (signUpError.code == "ERROR_EMAIL_ALREADY_IN_USE") {
          print("The email address is already in use by another account");
        }
      }
      print(signUpError.toString());
      return null;
    }
  }

  // sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
