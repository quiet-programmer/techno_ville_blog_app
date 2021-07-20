import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/auth/reg_final.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/provider/theme_provider.dart';
import 'package:techno_vile_blog/services/auth.dart';

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
    final checkTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: checkTheme.isLight ? backColorOne : backColor,
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
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: checkTheme.isLight ? boxColor : containerColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      validator: (val) {
                        if (val != null && val.isEmpty) {
                          return "Email must not be empty";
                        } else if (!val!.contains("@")) {
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
                      color: checkTheme.isLight ? boxColor : containerColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      validator: (val) {
                        if (val != null && val.isEmpty) {
                          return "Password must not be empty";
                        } else if (val!.length < 8) {
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: NiceButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              dynamic result =
                                  await _userAuth.registerUser(email, pwd);
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
