import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  textTheme: const TextTheme(
    subtitle1: TextStyle(
      fontSize: 17,
      color: Colors.white70,
      fontWeight: FontWeight.w400,
    ),
    subtitle2: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
    ),
    caption: TextStyle(
        fontWeight: FontWeight.w400, fontSize: 10, color: Colors.white70),
    bodyText2: TextStyle(
      color: Colors.white,
    ),
  ),
  brightness: Brightness.dark,
  primaryColor: Colors.grey[800],
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue[400],
    disabledColor: Colors.grey,
  ),
  // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red),
);

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    disabledColor: Colors.grey,
  ),
  // colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.pink),
);
