import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
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
  Future signInUser(String email, String pwd, {context}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: pwd)
          .then((result) {
        User user = result.user;
        return _userFromFirebaseuser(user);
      }).catchError((err) {
        if (err.code == 'user-not-found') {
          Flushbar(
            message: "No user found for that email.",
            duration: Duration(seconds: 7),
          )..show(context);
        } else if (err.code == 'wrong-password') {
          Flushbar(
            message: "Wrong password provided.",
            duration: Duration(seconds: 7),
          )..show(context);
        } else {
          Flushbar(
            message: "Internal Error: Something went wrong.",
            duration: Duration(seconds: 7),
          )..show(context);
        }
      });
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
      await DatabaseService(uid: user.uid).setUserData("firstName", "lastName");
      return _userFromFirebaseuser(user);
    } catch (signUpError) {
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
