import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/business_logic/bloc/search_bloc.dart';
import 'package:watchlist/presentation/widgets/movie-card.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchQuery = new TextEditingController();
  Timer _debounce;

  @override
  void initState() {
    super.initState();
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<SearchBloc>(context)
          .add(SearchLoadEvent(_searchQuery.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 4.0),
          child: TextField(
            controller: _searchQuery,
            decoration: InputDecoration(hintText: 'Search'),
          ),
        ),
        // SizedBox(height: 8.0),
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchInitial) {
                return Center(
                  child: Text(
                    'Search films',
                    style: TextStyle(fontSize: 20.0),
                  ),
                );
              }
              if (state is SearchError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Something went wrong. Please try again later.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                  ),
                );
              }
              if (state is SearchLoaded) {
                return GridView.builder(
                  padding: const EdgeInsets.all(4.0),
                  itemCount: state.loadedMovies.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300.0,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return MovieCard(movie: state.loadedMovies[index]);
                  },
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
