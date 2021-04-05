import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../business_logic/bloc/search_bloc.dart';
import '../../data/models/movie.dart';
import 'movies_paginated_grid.dart';
import 'styled_text.dart';

class SearchGrid extends StatefulWidget {
  @override
  _SearchGridState createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  final _pagingController = PagingController<int, Movie>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    final _bloc = context.read<SearchBloc>();
    _setPaginationInitialState(_bloc);
    _pagingController.addPageRequestListener((pageKey) {
      _bloc.add(SearchNextPageLoadEvent());
    });
  }

  void _setPaginationInitialState(bloc) {
    final SearchState blocState = bloc.state;
    if (blocState.status == SearchStatus.loaded) {
      _pagingController.value = PagingState(
        itemList: blocState.loadedMovies,
        error: null,
        nextPageKey: blocState.nextPageKey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state.status == SearchStatus.failure) {
          _pagingController.error = state.error;
        } else if (state.status == SearchStatus.loaded) {
          _pagingController.value = PagingState(
            itemList: state.loadedMovies,
            error: null,
            nextPageKey: state.nextPageKey,
          );
        }
      },
      builder: (context, state) {
        if (state.status == SearchStatus.initial) {
          return StyledText(text: 'Start Searching');
        } else if (state.status == SearchStatus.loading) {
          return Center(child: CircularProgressIndicator());
        }
        return MoviesPaginatedGrid(pagingController: _pagingController);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }
}
