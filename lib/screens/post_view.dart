import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/models/post_model.dart';
import 'package:techno_vile_blog/services/database.dart';

class PostView extends StatefulWidget {
  final PostModel postModel;

  PostView({
    Key key,
    this.postModel,
  }) : super(key: key);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView>
    with SingleTickerProviderStateMixin {
  final DatabaseService _databaseService = DatabaseService();

  String comments;

  Animation<double> _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    // animation for bubble up
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  CollectionReference postData =
      FirebaseFirestore.instance.collection('postData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subColor,
      endDrawer: Drawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      /// start of action button ///
      floatingActionButton: FloatingActionBubble(
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),
        iconColor: Colors.white,
        backGroundColor: containerColor,
        iconData: Icons.mode_comment,
        animation: _animation,
        items: <Bubble>[
          Bubble(
            title: "Add Comments",
            titleStyle: TextStyle(
              color: Colors.white,
            ),
            iconColor: Colors.white,
            bubbleColor: containerColor,
            icon: Icons.add_comment,
            onPress: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          // controller: comments,
                          onChanged: (val) {
                            comments = val;
                          },
                          decoration: InputDecoration(
                            hintText: "Drop your comments",
                          ),
                          maxLines: 10,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        NiceButton(
                          onPressed: () {
                            if (comments != null) {
                              _databaseService
                                  .updateDatawithComments(
                                      comments, widget.postModel.docId)
                                  .then((value) => Navigator.of(context).pop());
                            }
                          },
                          text: "Comment",
                          background: containerColor,
                          radius: 6.0,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Bubble(
            title: "Comments",
            titleStyle: TextStyle(
              color: Colors.white,
            ),
            iconColor: Colors.white,
            bubbleColor: containerColor,
            icon: Icons.comment,
            onPress: () {
              showModalBottomSheet(
                context: context,
                builder: (_) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    color: subColor,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "All Comments",
                              style: TextStyle(
                                fontSize: 25.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          FutureBuilder<QuerySnapshot>(
                            future: postData
                                .doc(widget.postModel.docId)
                                .collection("comments")
                                .get(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: snapshot.data.docs
                                        .map((DocumentSnapshot doc) {
                                      Timestamp datetime = doc.data()['time'];
                                      var data = DateFormat.MMMd()
                                          .format(datetime.toDate());
                                      var time = DateFormat.jm()
                                          .format(datetime.toDate());
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 100.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: containerColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: ListView(
                                                      children: [
                                                        Text(
                                                          "${doc.data()['comments']}",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18.0,
                                                          ),
                                                          softWrap: true,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Text(
                                                      "Time: $data, $time",
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 7.0,
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    "No Comments",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),

      /// end of floating action button ///
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6.0),
                    bottomRight: Radius.circular(6.0),
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.postModel.image,
                  fit: BoxFit.cover,
                  height: 350.0,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                widget.postModel.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "writen by ${widget.postModel.authur}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                "${DateFormat.yMMMMEEEEd().format(widget.postModel.time.toDate())}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                "${DateFormat.jm().format(widget.postModel.time.toDate())}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                widget.postModel.article,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
