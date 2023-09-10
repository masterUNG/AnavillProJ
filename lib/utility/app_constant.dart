import 'package:flutter/material.dart';

class AppConstant {
  static String urlPromPay =
      'https://firebasestorage.googleapis.com/v0/b/ditproject-52990.appspot.com/o/Qrpayment%2F355914621_260476469922539_853846598839689794_n.jpg?alt=media&token=d406dfcb-9759-4342-8b49-cbb4d6b11c2c';

  static int timePasswordFalse = 5;
  static Color bgColor = Colors.yellow;
  static Color dark = Colors.black;
  static Color active = const Color.fromARGB(255, 255, 60, 46);
  static Color active1 = Color.fromARGB(255, 3, 125, 30);
  static Color fieldColor = Colors.white;

  BoxDecoration borderCurveBox() => BoxDecoration(border: Border.all(),borderRadius: BorderRadius.circular(30));
  //BorderRadius.circular(30) เส้นโค้งของขอบ

  BoxDecoration curveBox() => BoxDecoration(
        //ทำกรอป
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(),
      );
 
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

  TextStyle h2Style({TextDecoration? textDecoration, Color? color}) {
    return AppConstant().appStyle(
      size: 20,
      textDecoration: textDecoration,
      color: color,
    );
  }

  TextStyle h3Style({Color? color, double? size, FontWeight? fontWeight}) {
    return AppConstant()
        .appStyle(size: size ?? 14, fontWeight: fontWeight, color: color);
  }


  TextStyle h4Style({Color? color, double? size, FontWeight? fontWeight}) {
    return AppConstant()
        .appStyle(size: size ?? 50, fontWeight: fontWeight, color: color);
  }



  TextStyle h5Style({Color? color, double? size, FontWeight? fontWeight}) {
    return AppConstant()
        .appStyle(size: size ?? 40, fontWeight: fontWeight, color: color);
  }
}

