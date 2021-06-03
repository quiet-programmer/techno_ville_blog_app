import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techno_vile_blog/models/post_model.dart';
import 'package:techno_vile_blog/models/user_models.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // user collection
  CollectionReference _userCollections =
      FirebaseFirestore.instance.collection('userData');

  // post collection
  CollectionReference _postCollections =
      FirebaseFirestore.instance.collection('postData');

  // set the user data
  Future setUserData(String firstName, String lastName) async {
    return await _userCollections.doc(uid).set({
      "firstName": firstName,
      "lastName": lastName,
    });
  }

  // update the user data
  Future updateUserData(userData) async {
    return await _userCollections.doc(uid).set(userData);
  }

  // send comments to post
  Future<void> updateDatawithComments(
      String commentData, String documentId) async {
    _postCollections.doc(documentId).collection("comments").add({
      "comments": commentData,
      "time": DateTime.now(),
    });
  }

  getComments(String documentId) async {
    return await _postCollections.doc(documentId).collection("comments").get();
  }

  // get user data from snapshop
  UserDataModels _userFromSnapshop(DocumentSnapshot snapshot) {
    return UserDataModels(
      uid: uid,
      firstName: snapshot.get('firstName'),
      lastName: snapshot.get('lastName'),
    );
  }

  // get user info
  Stream<UserDataModels> get userData {
    return _userCollections.doc(uid).snapshots().map(_userFromSnapshop);
  }

  // list of all post
  List<PostModel> _postFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PostModel(
        docId: doc.id,
        title: doc.get('title') ?? '',
        authur: doc.get('author') ?? '',
        article: doc.get('article') ?? '',
        image: doc.get('imageUrl') ?? '',
        time: doc.get('time') ?? '',
      );
    }).toList();
  }

  // get post from firestore
  Stream<List<PostModel>> get post {
    return _postCollections.snapshots().map(_postFromSnapshot);
  }
}
