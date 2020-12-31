import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/models/user_models.dart';
import 'package:techno_vile_blog/services/auth.dart';
import 'package:techno_vile_blog/services/database.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthServices _userAuth = AuthServices();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModels>(context);
    return Scaffold(
      backgroundColor: subColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Container(
                height: 150.0,
                width: 150.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              StreamBuilder<UserDataModels>(
                stream: DatabaseService(uid: user.uid).userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserDataModels userInfo = snapshot.data;
                    return Container(
                        child: Column(
                      children: [
                        userInfo != null
                            ? Text(
                                "${userInfo.firstName} ${userInfo.lastName}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              )
                            : Text(
                                "Welcome Anon",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                      ],
                    ));
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Text(
                      "...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Text(
                          "Something went wrong",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text("Refresh"),
                        ),
                      ],
                    );
                  }
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              SwitchListTile(
                value: true,
                onChanged: (val) {},
                title: Text(
                  "Notifications",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  "enable to get notify for new contact or events",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 15.0,
              ),
              ListTile(
                title: Text(
                  "About App",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  "brift info about the app",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 15.0,
              ),
              ListTile(
                title: Text(
                  "Rate App",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  "how is your experience with the app, please tell us",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.rate_review,
                  color: Colors.white,
                ),
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 15.0,
              ),
              ListTile(
                title: Text(
                  "App Liences",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  "get to see what the app has access to",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.library_books,
                  color: Colors.white,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return AboutDialog(
                        applicationName: "Techno Ville",
                        applicationIcon: Image.asset(
                          'assets/images/techno_dark.png',
                          height: 50.0,
                          width: 50,
                        ),
                        applicationVersion: "1.0.0",
                      );
                    },
                  );
                },
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 15.0,
              ),
              Card(
                color: Colors.redAccent,
                child: ListTile(
                  title: Text(
                    "Sign out",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.signOutAlt,
                    color: Colors.white,
                  ),
                  onTap: () async {
                    await _userAuth.signout();
                    print("Signed out");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
