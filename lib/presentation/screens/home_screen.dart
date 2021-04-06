import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'favorites.dart';
import 'now_playing.dart';
import 'search.dart';
import 'top_rated.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final PageStorageBucket _bucket = PageStorageBucket();
  int _currentIndex = 0;
  final List<Widget> _pages = <Widget>[
    Favorites(key: PageStorageKey('favoritesPage')),
    Search(key: PageStorageKey('searchPage')),
    NowPlaying(key: PageStorageKey('newPage')),
    TopRated(key: PageStorageKey('topPage')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: _auth.signOut,
          ),
        ],
      ),
      body: PageStorage(
        bucket: _bucket,
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.to_watch,
            icon: Icon(Icons.favorite_border),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.search,
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.now_playing,
            icon: Icon(Icons.fiber_new),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.top_rated,
            icon: Icon(Icons.sort),
          ),
        ],
      ),
    );
  }
}
