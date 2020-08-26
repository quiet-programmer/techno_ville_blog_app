import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:techno_vile_blog/const_value.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: subColor,
      child: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
