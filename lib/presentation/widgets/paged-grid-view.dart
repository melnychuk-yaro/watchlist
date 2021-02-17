import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:watchlist/presentation/widgets/movies-paginated-grid.dart';

class PagedMoviesGridView extends StatefulWidget {
  final Cubit movCubit;
  final Function loadMovies;
  final Function resetMovies;
  PagedMoviesGridView({
    @required this.movCubit,
    @required this.loadMovies,
    @required this.resetMovies,
  });

  @override
  _PagedMoviesGridViewState createState() => _PagedMoviesGridViewState();
}

class _PagedMoviesGridViewState extends State<PagedMoviesGridView> {
  final _pagingController = PagingController<int, Movie>(firstPageKey: 1);
  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      widget.loadMovies(1);
    });
    _streamSubscription = widget.movCubit.listen((state) {
      if (state.error != null) {
        _pagingController.error = state.error;
      } else {
        state.moviesPage.isLastPage
            ? _pagingController.appendLastPage(state.moviesPage.itemList)
            : _pagingController.appendPage(
                state.moviesPage.itemList, state.nextPageKey);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.resetMovies();
    _pagingController.dispose();
    _streamSubscription.cancel();
  }

  build(context) {
    return MoviesPaginatedGrid(pagingController: _pagingController);
  }
}
