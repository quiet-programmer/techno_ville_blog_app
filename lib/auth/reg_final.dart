import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/models/user_models.dart';
import 'package:techno_vile_blog/services/auth.dart';
import 'package:techno_vile_blog/services/database.dart';

class RegFinal extends StatefulWidget {
  @override
  _RegFinalState createState() => _RegFinalState();
}

class _RegFinalState extends State<RegFinal> {
  final AuthServices _userAuth = AuthServices();

  final _formKey = GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModels>(context);
    return Scaffold(
      backgroundColor: subColor,
      appBar: AppBar(
        actions: [
          FlatButton.icon(
            onPressed: () async {
              dynamic result = await _userAuth.anonSingin();

              if (result == null) {
                print("Something went wrong");
              } else {
                Navigator.of(context).pop();
                print("Signed in");
                print(result.uid);
              }
            },
            icon: Icon(Icons.person_pin_circle, color: Colors.white),
            label: Text(
              "Sign in Anon",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/techno.png',
                    width: 150.0,
                    height: 150.0,
                  ),
                  Text(
                    "Setup Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  Text(
                    "Please you might not be allowed to change or edit this, input you correct names",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  Text(
                    errorText,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      onChanged: (val) {
                        firstName = val;
                      },
                      decoration: InputDecoration(
                        hintText: "First Name",
                        enabledBorder: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: subColor,
                      ),
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      onChanged: (val) {
                        lastName = val;
                      },
                      decoration: InputDecoration(
                        hintText: "Last Name",
                        enabledBorder: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: subColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  NiceButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        DatabaseService(uid: user.uid)
                            .updateUserData(firstName, lastName);
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
