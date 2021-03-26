import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.white,
  textTheme: TextTheme(bodyText1: TextStyle(fontSize: 42, fontWeight: FontWeight.w500, color: Colors.white)),
  primaryTextTheme: TextTheme(bodyText1: TextStyle(fontSize: 16, color: Colors.black)),
);

final darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.black54,
  textTheme: TextTheme(bodyText1: TextStyle(fontSize: 42, fontWeight: FontWeight.w500, color: Colors.white)),
  primaryTextTheme: TextTheme(bodyText1: TextStyle(fontSize: 16, color: Colors.black)),
);

