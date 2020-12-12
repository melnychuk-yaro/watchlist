import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/bloc/movies_bloc.dart';
import 'package:watchlist/bloc/search_bloc.dart';
import 'package:watchlist/screens/favorites.dart';
import 'package:watchlist/screens/search.dart';
import 'package:watchlist/screens/top-rated.dart';
import 'package:watchlist/screens/now-playing.dart';
import 'package:watchlist/services/movies_repository.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var _currentIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    Favorites(),
    Search(),
    NowPlaying(),
    TopRated(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MoviesBloc>(
          create: (context) => MoviesBloc(MoviesRepository()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(MoviesRepository()),
        ),
      ],
      child: Scaffold(
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
          type: BottomNavigationBarType.fixed,
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
      ),
    );
  }
}
