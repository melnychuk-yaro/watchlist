import 'package:flutter/material.dart';

class DarkTheme {
  final Color color = Colors.indigoAccent.shade100;
  final Color darkColor = const Color(0xFF424242);

  ThemeData get themeData => ThemeData.dark().copyWith(
        primaryColor: color,
        accentColor: color,
        toggleableActiveColor: color,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: darkColor,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData().copyWith(
          selectedItemColor: color,
          unselectedIconTheme: IconThemeData(color: Colors.white),
          backgroundColor: darkColor,
        ),
        textSelectionTheme: TextSelectionThemeData().copyWith(
          selectionColor: color,
          selectionHandleColor: color,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: color,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
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
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: darkColor,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: color,
              width: 2,
            ),
          ),
        ),
      );
}
