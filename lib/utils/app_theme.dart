import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF1A3C34);
  static const Color darkPrimaryColor = Color(0xFF23433A);
  static const Color secondaryColor = Color(0xFFF4A261);
  static const Color backgroundColor = Color(0xFFF8F8F8);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: backgroundColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: primaryColor),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
        textStyle: WidgetStatePropertyAll(TextStyle(color: primaryColor))
      )
    )
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFF232323),
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: Color(0xFF1E1E1E),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.white60),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: darkPrimaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              textStyle: WidgetStatePropertyAll(TextStyle(color: Colors.white))
          )
      )
  );
}
