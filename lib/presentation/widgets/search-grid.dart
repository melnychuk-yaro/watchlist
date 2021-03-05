import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:watchlist/business_logic/bloc/search_bloc.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/presentation/widgets/movies-paginated-grid.dart';

class SearchGrid extends StatefulWidget {
  @override
  _SearchGridState createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  final _pagingController = PagingController<int, Movie>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    SearchBloc _bloc = context.read<SearchBloc>();
    _setPaginationIntialState(_bloc);
    _pagingController.addPageRequestListener((pageKey) {
      _bloc.add(SearchNextPageLoadEvent());
    });
  }

  void _setPaginationIntialState(bloc) {
    final SearchState blocState = bloc.state;
    if (blocState is SearchLoaded) {
      _pagingController.value = PagingState(
        itemList: blocState.loadedMovies,
        error: null,
        nextPageKey: blocState.nextPageKey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is SearchError) {
          _pagingController.error = 'Something went wrong';
        }
        if (state is SearchLoaded) {
          _pagingController.value = PagingState(
            itemList: state.loadedMovies,
            error: null,
            nextPageKey: state.nextPageKey,
          );
        }
      },
      child: MoviesPaginatedGrid(pagingController: _pagingController),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }
}
