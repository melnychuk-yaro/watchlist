import 'package:flutter/material.dart';
import 'package:watchlist/screens/favorites.dart';
import 'package:watchlist/screens/login.dart';

void main() {
  runApp(WatchListApp());
}

class WatchListApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watchlist',
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.indigoAccent,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.indigoAccent,
        ),
      ),
      home: LoginScreen(),
    );
  }
}
