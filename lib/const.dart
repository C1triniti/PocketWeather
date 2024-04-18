import 'package:flutter/material.dart';


const OPENWEATHER_API_KEY = "4dcbcabd1eedc98e77555e265d9fc37f";

ThemeData lightMode = ThemeData(
  brightness:Brightness.light,
  textTheme:  const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  textTheme:  const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
  )
);