import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techno_vile_blog/utils/hex_to_color.dart';

const Color realColor = Color.fromRGBO(50, 129, 222, 1);
// const Color subColor = Color.fromRGBO(0, 0, 0, 1);
Color backColor = Colors.grey[900];
Color backColorOne = Colors.grey[100];
Color subColor = Colors.grey[850];

const Color containerColor = Color.fromRGBO(42, 44, 49, 1);
const Color boxColor = Color.fromRGBO(235, 237, 242, 1);

Color textLight = hexToColor("#ffffff");
Color textDark = hexToColor("#0e0e0f");

Widget lightTabLogo() {
  return Image.asset(
    'assets/images/techno_vile.png',
    width: 200.0,
    height: 150.0,
  );
}

Widget lightLogo() {
  return Image.asset(
    'assets/images/techno.png',
    width: 150.0,
    height: 150.0,
  );
}

Widget darkTabLogo() {
  return Image.asset(
    'assets/images/techno_vile_dark.png',
    width: 200.0,
    height: 150.0,
  );
}

Widget darkLogo() {
  return Image.asset(
    'assets/images/techno_dark.png',
    width: 150.0,
    height: 150.0,
  );
}
