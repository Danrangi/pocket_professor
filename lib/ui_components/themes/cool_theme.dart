import 'package:flutter/material.dart';

class CoolTheme {
  // Dark theme with purple accents
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.purple[600],
      scaffoldBackgroundColor: Color(0xFF121212),
      colorScheme: ColorScheme.dark(
        primary: Colors.purple[600]!,
        secondary: Colors.blue[400]!,
        surface: Color(0xFF1E1E1E),
        background: Color(0xFF121212),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF1E1E1E),
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: Color(0xFF1E1E1E),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Color(0xFF2C2C2C),
      ),
    );
  }
}
