import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/presentation/screens/favorites.dart';
import 'package:watchlist/presentation/screens/search.dart';
import 'package:watchlist/presentation/screens/top-rated.dart';
import 'package:watchlist/presentation/screens/now-playing.dart';

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
    Search(key: PageStorageKey('Page2')),
    NowPlaying(key: PageStorageKey('Page3')),
    TopRated(key: PageStorageKey('Page4')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _auth.signOut(),
          )
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
            label: 'To Watch',
            icon: Icon(Icons.favorite_border),
          ),
          BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: 'Now Playing',
            icon: Icon(Icons.fiber_new),
          ),
          BottomNavigationBarItem(
            label: 'Top Rated',
            icon: Icon(Icons.sort),
          ),
        ],
      ),
    );
  }
}
