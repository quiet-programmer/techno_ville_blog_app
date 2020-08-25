import 'package:flutter/material.dart';
import 'package:techno_vile_blog/services/auth.dart';

class RegsiterScreen extends StatefulWidget {
  @override
  _RegsiterScreenState createState() => _RegsiterScreenState();
}

class _RegsiterScreenState extends State<RegsiterScreen> {
  final AuthServices _userAuth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Center(child: Text("Register")),
    );
  }
}
