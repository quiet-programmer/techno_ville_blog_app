import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/models/user_models.dart';
import 'package:techno_vile_blog/provider/theme_provider.dart';
import 'package:techno_vile_blog/services/database.dart';

class RegFinal extends StatefulWidget {
  @override
  _RegFinalState createState() => _RegFinalState();
}

class _RegFinalState extends State<RegFinal> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();

  String errorText = '';

  @override
  void dispose() {
    super.dispose();
    _firstName.dispose();
    _lastName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModels>(context);
    final checkTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  checkTheme.isLight ? darkLogo() : lightLogo(),
                  Text(
                    "Setup Profile",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    "Please you might not be allowed to change or edit this, input you correct names",
                    style: TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return "First name must not be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: _firstName,
                      decoration: InputDecoration(
                        hintText: "First Name",
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: containerColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      validator: (val) {
                        if (val.isEmpty) {
                          return "Last name must not be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: _lastName,
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  NiceButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        var firstName = _firstName.text;
                        var lastName = _lastName.text;
                        DatabaseService(uid: user.uid)
                            .setUserData(firstName, lastName);
                        print("Account Created");
                        Navigator.of(context).pop();
                      }
                    },
                    radius: 10.0,
                    text: "Finish",
                    textColor: Colors.black,
                    background: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
