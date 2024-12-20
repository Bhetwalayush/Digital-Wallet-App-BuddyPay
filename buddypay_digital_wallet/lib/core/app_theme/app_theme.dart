import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: const Color(0xff304F50),
    fontFamily: 'Montserrat Regular',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
            fontSize: 18,
            // color: Colors.teal,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat Bold'),
        backgroundColor: const Color(0xFF00C9A7),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Colors.white),
        ),
      ),
    ),
  );
}
