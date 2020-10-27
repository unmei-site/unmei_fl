import 'package:flutter/material.dart';

enum ThemeConfig {
  light,
  dark,
  blueDark,
  redDark,
  greenDark,
}

final appThemeData = {
  ThemeConfig.light: ThemeData(
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.lime)),
      primaryColor: Colors.black),
  ThemeConfig.dark: ThemeData(
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.indigo)),
      primaryColor: Colors.teal),
  ThemeConfig.blueDark: ThemeData(
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.pink)),
      primaryColor: Colors.yellow),
  ThemeConfig.redDark: ThemeData(
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.green)),
      primaryColor: Colors.blue),
  ThemeConfig.greenDark: ThemeData(
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.orangeAccent)),
      primaryColor: Colors.cyan),
};
