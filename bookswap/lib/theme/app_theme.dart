import 'package:flutter/material.dart';

class AppTheme {
  static const Color navyBlue = Color(0xFF0A1D37);
  static const Color yellowAccent = Color(0xFFFFC107);
  static const Color lightGrey = Color(0xFFB0BEC5);

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: navyBlue,
    primaryColor: yellowAccent,
    appBarTheme: const AppBarTheme(
      backgroundColor: navyBlue,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
      titleLarge: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: yellowAccent,
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: navyBlue,
      selectedItemColor: yellowAccent,
      unselectedItemColor: Colors.white70,
      showUnselectedLabels: true,
    ),
  );

  // simple light theme matching the screenshots (light surface with navy accents)
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[50],
    primaryColor: yellowAccent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
      titleLarge: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: yellowAccent,
      foregroundColor: Colors.black,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: navyBlue,
      selectedItemColor: yellowAccent,
      unselectedItemColor: Colors.white70,
      showUnselectedLabels: true,
    ),
  );
}
