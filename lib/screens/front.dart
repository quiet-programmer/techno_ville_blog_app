import 'package:flutter/material.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:techno_vile_blog/auth/signin.dart';
import 'package:techno_vile_blog/const_value.dart';

class FrontScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subColor,
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/techno.png',
                  width: 150.0,
                  height: 150.0,
                ),
                Text(
                  "Your Number One",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                Text(
                  "Tech Hotspot",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(
                  height: 150.0,
                ),
                NiceButton(
                  onPressed: () {},
                  radius: 16.0,
                  text: "Create an Account",
                  textColor: Colors.black,
                  background: Colors.white,
                ),
                SizedBox(
                  height: 20.0,
                ),
                NiceButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return SigninScreen();
                    }));
                  },
                  radius: 16.0,
                  text: "Login Here",
                  textColor: Colors.black,
                  background: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
