import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:watchlist/business_logic/bloc/search_bloc.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/presentation/widgets/movies-grid.dart';

class SearchGrid extends StatefulWidget {
  @override
  _SearchGridState createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  final _pagingController = PagingController<int, Movie>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      BlocProvider.of<SearchBloc>(context).add(SearchNextPageLoadEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchError) {
          //TODO: handle errors
          _pagingController.error = 'Something went wrong';
        }
        if (state is SearchLoaded) {
          state.isLastPage
              ? _pagingController.appendLastPage(state.loadedMovies)
              : _pagingController.appendPage(
                  state.loadedMovies, state.nextPageKey);
        }
      },
      builder: (context, state) {
        if (state is SearchInitial) {
          return Center(
            child: Text('Search Movies'),
          );
        }
        if (state is SearchLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return MoviesGrid(pagingController: _pagingController);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }
}
