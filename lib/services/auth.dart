import 'package:firebase_auth/firebase_auth.dart';
import 'package:techno_vile_blog/models/user_models.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase user
  UserModels _userFromFirebaseuser(FirebaseUser user) {
    return user != null ? UserModels(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<UserModels> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseuser);
  }

  //sign in anon
  Future anonSingin() async {
    try {
      AuthResult results = await _auth.signInAnonymously();
      FirebaseUser user = results.user;
      return _userFromFirebaseuser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and pwd

  // register with email and pwd

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
