import 'package:flutter/material.dart';

class Palette {
  static const kScaffoldColor = Color.fromRGBO(250, 250, 250, 1);
  static const kPrimaryColor = Color.fromRGBO(74, 165, 153, 1);
  static const kDarkGreyColor = Color.fromRGBO(105, 111, 111, 1);
  static const kLightRedColor = Color.fromRGBO(165, 116, 116, 1);
  static const kDangerRedColor = Color.fromRGBO(227, 31, 31, 1);
  static const kWhiteColor = Colors.white;
  static final opacityGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Colors.black.withOpacity(0.4), Colors.transparent],
  );
}
