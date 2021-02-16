import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/business_logic/bloc/search_bloc.dart';
import 'package:watchlist/business_logic/cubit/now_playing_cubit.dart';
import 'package:watchlist/business_logic/cubit/top_movies_cubit.dart';
import 'package:watchlist/presentation/screens/favorites.dart';
import 'package:watchlist/presentation/screens/search.dart';
import 'package:watchlist/presentation/screens/top-rated.dart';
import 'package:watchlist/presentation/screens/now-playing.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

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
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(MoviesRepository()),
        ),
        BlocProvider<TopMoviesCubit>(
          create: (context) => TopMoviesCubit(MoviesRepository()),
        ),
        BlocProvider<NowPlayingCubit>(
          create: (context) => NowPlayingCubit(MoviesRepository()),
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
