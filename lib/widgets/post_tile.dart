import 'package:flutter/material.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/models/post_model.dart';

class PostTile extends StatefulWidget {
  final PostModel posts;

  PostTile({this.posts});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Card(
        color: containerColor,
        child: ListTile(
          title: Text(
            "${widget.posts.title}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "written by ${widget.posts.authur}",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
