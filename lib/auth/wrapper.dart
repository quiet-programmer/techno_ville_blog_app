import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/auth/signin.dart';
import 'package:techno_vile_blog/models/user_models.dart';
import 'package:techno_vile_blog/screens/tab_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModels>(context);
    if (user == null) {
      return SigninScreen();
    } else {
      return TabScreen();
    }
  }
}
