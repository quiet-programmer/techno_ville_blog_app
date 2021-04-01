import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/models/user_models.dart';
import 'package:techno_vile_blog/provider/theme_provider.dart';
import 'package:techno_vile_blog/services/auth.dart';
import 'package:techno_vile_blog/services/database.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthServices _userAuth = AuthServices();

  File _selectedImage;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModels>(context);
    final checkTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: checkTheme.isLight ? backColorOne : backColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              StreamBuilder<UserDataModels>(
                stream: DatabaseService(uid: user.uid).userData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserDataModels userInfo = snapshot.data;
                    return Container(
                        child: Column(
                      children: [
                        _selectedImage != null
                            ? InkWell(
                                onTap: () => getImage(),
                                child: Container(
                                  height: 150.0,
                                  width: 150.0,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50.0),
                                    image: DecorationImage(
                                      image: FileImage(_selectedImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () => getImage(),
                                child: Container(
                                  height: 150.0,
                                  width: 150.0,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(50.0)),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          "${userInfo.firstName} ${userInfo.lastName}",
                          style: TextStyle(
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
                        fontSize: 20.0,
                      ),
                    );
                  } else {
                    return Column(
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
                        Text(
                          "Welcome Anon",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
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
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  "enable to get notify for new contact or events",
                  style: TextStyle(),
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
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  "brift info about the app",
                  style: TextStyle(),
                ),
                trailing: Icon(
                  Icons.info_outline,
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
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  "how is your experience with the app, please tell us",
                  style: TextStyle(),
                ),
                trailing: Icon(
                  Icons.rate_review,
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
                    fontSize: 20.0,
                  ),
                ),
                subtitle: Text(
                  "get to see what the app has access to",
                  style: TextStyle(),
                ),
                trailing: Icon(
                  Icons.library_books,
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
