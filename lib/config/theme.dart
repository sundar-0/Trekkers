import 'package:flutter/material.dart';
ThemeData theme() {
  return ThemeData(
    colorScheme: ColorScheme.light().copyWith(primary: Color(0xFFFE3C5B)),
    primaryColorDark: Color(0xFFFC0028),
    primaryColorLight: Color(0xFFFE9AAA),
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Color(0xFFF5F5F5),
    fontFamily: 'futura',
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      headline2: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      headline3: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headline4: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headline5: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      headline6: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      bodyText1: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      bodyText2: TextStyle(
        color: Color(0xff1b070b),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    ),
  );
}
