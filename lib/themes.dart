import 'package:flutter/material.dart';

class DefautTheme {
  ThemeData get theme => ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent[200],
        accentColor: Colors.blueAccent[200],
        toggleableActiveColor: Colors.blueAccent[200],
        textSelectionHandleColor: Colors.blueAccent[200],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            textStyle: TextStyle(fontSize: 18.0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(fontSize: 18.0),
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
              color: Colors.blueAccent[200],
              width: 3,
            ),
          ),
        ),
      );
}
