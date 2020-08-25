import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/services/auth.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthServices _userAuth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subColor,
      body: SingleChildScrollView(
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text(
                      "Sign out",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    trailing: FaIcon(FontAwesomeIcons.signOutAlt),
                    onTap: () async {
                      await _userAuth.signout();
                      print("Signed out");
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
