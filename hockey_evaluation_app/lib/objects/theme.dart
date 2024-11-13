import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Inter',
  brightness: Brightness.light,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.red,
    onPrimary: Colors.white,
    secondary: Colors.black,
    onSecondary: Colors.white,
    tertiary: Color.fromARGB(255, 128, 128, 128),
    onTertiary: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    error: Color.fromARGB(255, 255, 170, 170),
    onError: Color.fromARGB(255, 255, 100, 100),
    surface: Color.fromARGB(255, 228, 223, 221),
    onSurface: Color.fromARGB(255, 128, 128, 128),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontFamily: 'Inter',
      fontSize: 40,
    ),
    headlineLarge: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    headlineMedium: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    bodySmall: TextStyle(
      // Used for regular body text.
      color: Colors.black,
      fontFamily: 'Inter',
      fontSize: 8,
    ),
    labelLarge: TextStyle(
      // Used for dropdown menu text and search bar labels.
      color: Colors.white,
      fontFamily: 'Inter',
      fontSize: 15,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);