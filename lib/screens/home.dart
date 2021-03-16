import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/models/post_model.dart';
import 'package:techno_vile_blog/provider/theme_provider.dart';
import 'package:techno_vile_blog/services/database.dart';
import 'package:techno_vile_blog/shared/post_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final checkTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: checkTheme.isLight ? backColorOne : backColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Column(
            children: [
              Container(
                height: 160.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      height: 150.0,
                      width: 150.0,
                      padding: const EdgeInsets.only(bottom: 5.0),
                      decoration: BoxDecoration(
                        color: checkTheme.isLight ? boxColor : containerColor,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: checkTheme.isLight
                              ? AssetImage('assets/images/techno_dark.png')
                              : AssetImage('assets/images/techno.png'),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Meet Writters",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      height: 150.0,
                      width: 150.0,
                      padding: const EdgeInsets.only(bottom: 5.0),
                      decoration: BoxDecoration(
                        color: checkTheme.isLight ? boxColor : containerColor,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: checkTheme.isLight
                              ? AssetImage('assets/images/techno_dark.png')
                              : AssetImage('assets/images/techno.png'),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "See Events",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Container(
                      height: 150.0,
                      width: 150.0,
                      padding: const EdgeInsets.only(bottom: 5.0),
                      decoration: BoxDecoration(
                        color: checkTheme.isLight ? boxColor : containerColor,
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: checkTheme.isLight
                              ? AssetImage('assets/images/techno_dark.png')
                              : AssetImage('assets/images/techno.png'),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Drop a request",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "All Articles",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              StreamProvider<List<PostModel>>.value(
                value: DatabaseService().post,
                child: PostList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
