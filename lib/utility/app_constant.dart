import 'package:flutter/material.dart';

class AppConstant {
  static Color bgColor = Colors.yellow;
  static Color dark = Colors.black;
  static Color active = const Color.fromARGB(255, 255, 60, 46);
  static Color fieldColor = Colors.white;

  TextStyle appStyle({
    double? size,
    Color? color,
    FontWeight? fontWeight,
    TextDecoration? textDecoration,
  }) {
    return TextStyle(
      fontSize: size ?? 16,
      color: color ?? dark,
      fontWeight: fontWeight,
      fontFamily: 'FredokaOne',
      decoration: textDecoration,
    );
  }

  TextStyle h1Style() {
    return AppConstant().appStyle(
      size: 36,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style({TextDecoration? textDecoration,Color? color}) {
    return AppConstant().appStyle(
      size: 20,
      textDecoration: textDecoration,
      color: color,
    );
  }
}
