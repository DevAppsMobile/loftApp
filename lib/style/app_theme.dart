import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color textColor = Colors.black;
  static const Color buttonColorLight = Colors.black54;
  static const Color themeColor = Color(0XFF290FBA);
  static const Color textButtonColor = Color(0XFF290FBA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF1A1A1A);
  static const Color blue = Color(0xffb8cef6);
  static const Color red = Color(0xFFF11717);

  static const TextStyle textStyleHeading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    height: 1.5,
  );

  static const TextStyle textStyleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.black,
    height: 1.5,
  );
}
