import 'package:flutter/material.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthServices _userAuth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subColor,
      body: Center(
        child: Text(
          "Welcome Home",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
