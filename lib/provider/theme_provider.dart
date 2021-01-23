import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool isLight = true;

  void changeTheme() {
    isLight = !isLight;
    notifyListeners();
  }
}
