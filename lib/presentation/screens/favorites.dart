import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../business_logic/bloc/favorites_bloc.dart';
import '../../data/models/movie.dart';
import '../widgets/movies_paginated_grid.dart';
import '../widgets/styled_text.dart';

class Favorites extends StatefulWidget {
  final PageStorageKey key;
  Favorites({required this.key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final _pagingController = PagingController<int, Movie>(firstPageKey: 1);
  late FavoritesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<FavoritesBloc>();
    _setPaginationInitialState(_bloc.state);
    _pagingController.addPageRequestListener((nextPageKey) {
      _bloc.add(FavoritesLoad());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  void _setPaginationInitialState(state) {
    if (state.status == FavoritesStatus.loaded) {
      _pagingController.value = PagingState(
        itemList: state.loadedMovies,
        error: null,
        nextPageKey: state.nextPageKey,
      );
    }
  }

//
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state.status == FavoritesStatus.failure) {
          _pagingController.error = state.error;
        }

        if (state.status == FavoritesStatus.loaded) {
          _pagingController.value = PagingState(
            itemList: state.loadedMovies,
            error: null,
            nextPageKey: state.nextPageKey,
          );
        }
      },
      builder: (context, state) {
        if (state.status == FavoritesStatus.loading ||
            state.status == FavoritesStatus.initial) {
          return Center(child: CircularProgressIndicator());
        }
        if (state.loadedMovies.isEmpty &&
            state.status != FavoritesStatus.failure) {
          return StyledText(text: 'Add movies to your watchlist');
        }
        return MoviesPaginatedGrid(pagingController: _pagingController);
      },
    );
  }
}
