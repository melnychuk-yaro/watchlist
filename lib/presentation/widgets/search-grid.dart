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
  SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _searchBloc = BlocProvider.of<SearchBloc>(context);
    _pagingController.addPageRequestListener((pageKey) {
      print('---LISTEN---$pageKey');
      _searchBloc.add(SearchNextPageLoadEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        print('current state: $state');
        if (state is SearchInitial) {
          _pagingController.refresh();
        }
        if (state is SearchError) {
          //TODO: handle errors
          _pagingController.error = 'Something went wrong';
        }
        if (state is SearchLoaded) {
          _pagingController.value = PagingState(
            itemList: state.loadedMovies,
            error: null,
            nextPageKey: state.isLastPage ? null : state.nextPageKey,
          );
        }
      },
      builder: (context, state) {
        if (state is SearchInitial) {
          return Center(child: Text('Start searching'));
        }
        return MoviesPaginatedGrid(pagingController: _pagingController);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchBloc.add(SearchResetEvent());
    _pagingController.dispose();
  }
}
