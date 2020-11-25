import 'package:flutter/material.dart';
import 'package:watchlist/screens/favorites.dart';

void main() {
  runApp(WatchListApp());
}

class WatchListApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watchlist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Favorites(),
    );
  }
}
