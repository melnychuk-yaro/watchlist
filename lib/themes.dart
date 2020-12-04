import 'package:flutter/material.dart';

class DefautTheme {
  final Color color = Colors.deepOrangeAccent;

  ThemeData get theme => ThemeData.dark().copyWith(
        primaryColor: color,
        accentColor: color,
        toggleableActiveColor: color,
        textSelectionHandleColor: color,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: color,
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            textStyle: TextStyle(fontSize: 16.0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: color,
            textStyle: TextStyle(fontSize: 16.0),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(fontSize: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: BorderSide(
              color: Color(0xFF666666),
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24.0),
            borderSide: BorderSide(
              color: color,
              width: 2,
            ),
          ),
        ),
      );
}
