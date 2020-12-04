import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/screens/favorites.dart';
import 'package:watchlist/screens/search.dart';
import 'package:watchlist/screens/explore.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var _currentIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    Favorites(),
    Search(),
    Explore(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        backgroundColor: Theme.of(context).cardColor,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => auth.signOut(),
          )
        ],
      ),
      body: _widgetOptions.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Theme.of(context).cardColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Favs',
            icon: Icon(Icons.favorite_border),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Explore',
            icon: Icon(Icons.movie),
          ),
        ],
      ),
    );
  }
}
