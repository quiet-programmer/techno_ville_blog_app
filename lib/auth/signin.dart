import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:provider/provider.dart';
import 'package:techno_vile_blog/auth/resgiter.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/provider/theme_provider.dart';
import 'package:techno_vile_blog/services/auth.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthServices _userAuth = AuthServices();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _pwd = TextEditingController();

  final _pwdNode = FocusNode();

  bool isLoading = false;
  bool isAltLoading = false;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _pwd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkTheme = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: checkTheme.isLight ? backColorOne : backColor,
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () async {
              setState(() {
                isAltLoading = true;
              });
              dynamic result = await _userAuth.anonSingin();

              if (result == null) {
                setState(() {
                  isAltLoading = false;
                });
                print("Something went wrong");
              } else {
                // Navigator.of(context).pop();
                print("Signed in");
                print(result.uid);
              }
            },
            icon: Icon(Icons.person_pin_circle),
            label: Text(
              isAltLoading == true ? "Signing in.." : "Sign in Anon",
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
                  checkTheme.isLight ? darkLogo() : lightLogo(),
                  Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
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
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_pwdNode);
                      },
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r"\s")),
                      ],
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
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
                        } else {
                          return null;
                        }
                      },
                      focusNode: _pwdNode,
                      controller: _pwd,
                      decoration: InputDecoration(
                        hintText: "Password",
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: NiceButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              var email = _email.text;
                              var pwd = _pwd.text;
                              setState(() {
                                isLoading = true;
                              });
                              await _userAuth
                                  .signInUser(
                                email,
                                pwd,
                                context: context,
                              )
                                  .then((result) {
                                if (result == null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {}
                              });
                            } else {}
                          },
                          radius: 10.0,
                          text: isLoading == true ? "Checking..." : "Sign In",
                          textColor: Colors.black,
                          background: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return RegsiterScreen();
                      }));
                    },
                    child: Text("Don't have an account? Register here"),
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
