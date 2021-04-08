import 'package:flutter/material.dart';

import '../../constatns.dart';

class LightTheme {
  final Color color = Colors.indigoAccent;

  ThemeData get themeData => ThemeData().copyWith(
        primaryColor: color,
        accentColor: color,
        toggleableActiveColor: color,
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: Colors.white,
          textTheme: TextTheme(headline6: TextStyle().copyWith(color: color)),
          actionsIconTheme: IconThemeData().copyWith(color: color),
          iconTheme: IconThemeData(color: color),
        ),
        textSelectionTheme: TextSelectionThemeData().copyWith(
          selectionColor: color,
          selectionHandleColor: color,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: color,
            padding: const EdgeInsets.symmetric(
              horizontal: kPadding * 1.5,
              vertical: kPadding / 2,
            ),
            textStyle: const TextStyle(fontSize: 16.0),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: color,
            textStyle: const TextStyle(fontSize: 16.0),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: const TextStyle(fontSize: 16),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: const Color(0xFF666666),
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
