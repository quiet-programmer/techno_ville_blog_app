import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/models/post_model.dart';
import 'package:techno_vile_blog/screens/post_view.dart';

class PostTile extends StatefulWidget {
  final PostModel posts;

  PostTile({this.posts});

  @override
  _PostTileState createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
              return PostView(postModel: widget.posts);
            }));
          },
          child: Container(
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
                trailing: CachedNetworkImage(
                  imageUrl: widget.posts.image,
                  height: 120,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        )
      ],
    );
  }
}
