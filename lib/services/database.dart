import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:techno_vile_blog/models/post_model.dart';
import 'package:techno_vile_blog/models/user_models.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // user collection
  CollectionReference userCollections =
      Firestore.instance.collection('userData');

  // post collection
  CollectionReference postCollections =
      Firestore.instance.collection('postData');

  // update the user data
  Future updateUserData(String firstName, String lastName) async {
    return await userCollections.document(uid).setData({
      "firstName": firstName,
      "lastName": lastName,
    });
  }

  // send comments to post
  Future<void> updateDatawithComments(
      List<String> commentData, String documentId) async {
    postCollections.document(documentId).updateData({
      "comments": [commentData],
    });
  }

  // get user data from snapshop
  UserDataModels _userFromSnapshop(DocumentSnapshot snapshot) {
    return UserDataModels(
      uid: uid,
      firstName: snapshot.data['firstName'],
      lastName: snapshot.data['lastName'],
    );
  }

  // get user info
  Stream<UserDataModels> get userData {
    return userCollections.document(uid).snapshots().map(_userFromSnapshop);
  }

  // list of all post
  List<PostModel> _postFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PostModel(
        docId: doc.documentID,
        title: doc.data['title'] ?? '',
        authur: doc.data['author'] ?? '',
        article: doc.data['article'] ?? '',
        image: doc.data['imageUrl'] ?? '',
        time: doc.data['time'] ?? '',
      );
    }).toList();
  }

  // get post from firestore
  Stream<List<PostModel>> get post {
    return postCollections.snapshots().map(_postFromSnapshot);
  }
}
