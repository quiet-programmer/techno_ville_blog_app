import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/auth/wrapper.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/provider/theme_provider.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return Wrapper();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    final checkTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: checkTheme.isLight ? backColorOne : backColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              checkTheme.isLight ? darkLogo() : lightLogo(),
              Text(
                "Techno Ville",
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
