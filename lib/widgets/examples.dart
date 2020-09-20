import 'package:flutter/material.dart';

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Text("Title"),
                  subtitle: Text("Sub Title"),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text("Title"),
                  subtitle: Text("Sub Title"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
