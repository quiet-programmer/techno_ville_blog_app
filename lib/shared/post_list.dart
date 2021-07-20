import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/models/post_model.dart';
import 'package:techno_vile_blog/widgets/post_tile.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    final post = Provider.of<List<PostModel>>(context);
    return ListView.builder(
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: post.length,
      itemBuilder: (_, index) {
        return PostTile(
          posts: post[index],
        );
      },
    );
  }
}
