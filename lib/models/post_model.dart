import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String docId;
  final String title;
  final String authur;
  final String image;
  final String article;
  final String comments;
  final Timestamp time;

  PostModel({
    this.docId,
    this.title,
    this.authur,
    this.image,
    this.article,
    this.comments,
    this.time,
  });
}
