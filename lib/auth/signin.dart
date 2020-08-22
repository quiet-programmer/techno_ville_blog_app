import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:techno_vile_blog/const_value.dart';
import 'package:techno_vile_blog/services/auth.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final AuthServices _userAuth = AuthServices();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
      body: Container(
        height: MediaQuery.of(context).size.height,
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
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 100.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
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
                          onTap: () {},
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: NiceButton(
                          onPressed: () {},
                          radius: 10.0,
                          text: "Sign In",
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
