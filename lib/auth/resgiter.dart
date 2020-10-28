import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:techno_vile_blog/auth/reg_final.dart';
import 'package:techno_vile_blog/auth/signin.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/services/auth.dart';
import 'package:techno_vile_blog/shared/loading_widget.dart';

class RegsiterScreen extends StatefulWidget {
  @override
  _RegsiterScreenState createState() => _RegsiterScreenState();
}

class _RegsiterScreenState extends State<RegsiterScreen> {
  final AuthServices _userAuth = AuthServices();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String pwd = '';
  String errorText = '';

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? LoadingWidget()
        : Scaffold(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
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
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                        SizedBox(
                          height: 100.0,
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
                                return "Email must not be empty";
                              } else if (!val.contains("@")) {
                                return "Please enter a valid email";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              email = val;
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                              enabledBorder: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: subColor,
                            ),
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
                            obscureText: true,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Password must not be empty";
                              } else if (val.length < 8) {
                                return "Password must be 8 characters long";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              pwd = val;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
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
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return SigninScreen();
                                  }));
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: NiceButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    dynamic result = await _userAuth
                                        .registerUser(email, pwd);
                                    print("signed in");
                                    print(result.toString());
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (_) {
                                      return RegFinal();
                                    }));
                                    if (result == null) {
                                      setState(() {
                                        errorText = "Something went wrong";
                                        isLoading = false;
                                      });
                                    }
                                  }
                                },
                                radius: 10.0,
                                text: "Next",
                                textColor: Colors.black,
                                background: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
