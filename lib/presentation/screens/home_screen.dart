import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/bloc/auth_bloc.dart';
import 'subpages/favorites.dart';
import 'subpages/now_playing.dart';
import 'subpages/search.dart';
import 'subpages/top_rated.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageStorageBucket _bucket = PageStorageBucket();
  int _currentIndex = 0;
  final List<Widget> _pages = <Widget>[
    const Favorites(key: PageStorageKey('favoritesPage')),
    const Search(key: PageStorageKey('searchPage')),
    const NowPlaying(key: PageStorageKey('newPage')),
    const TopRated(key: PageStorageKey('topPage')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
        actions: [const LogoutButton()],
      ),
      body: PageStorage(
        bucket: _bucket,
        child: _pages.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: [
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.to_watch,
            icon: const Icon(Icons.favorite_border),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.search,
            icon: const Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.now_playing,
            icon: const Icon(Icons.fiber_new),
          ),
          BottomNavigationBarItem(
            label: AppLocalizations.of(context)!.top_rated,
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      onPressed: () => context.read<AuthBloc>().add(AuthLogoutRequested()),
    );
  }
}
