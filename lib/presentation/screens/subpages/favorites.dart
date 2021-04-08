import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../business_logic/bloc/favorites_bloc.dart';
import '../../../data/models/movie.dart';
import '../../widgets/movies_paginated_grid.dart';
import '../../widgets/styled_text.dart';

class Favorites extends StatefulWidget {
  final PageStorageKey key;
  const Favorites({required this.key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  late PagingController<int, Movie> _pagingController;
  late FavoritesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<FavoritesBloc>();
    _pagingController = PagingController<int, Movie>.fromValue(
      PagingState(
        itemList: _bloc.state.loadedMovies,
        error: _bloc.state.error,
        nextPageKey: _bloc.state.nextPageKey,
      ),
      firstPageKey: 1,
    );
    _pagingController.addPageRequestListener((nextPageKey) {
      _bloc.add(FavoritesLoad());
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
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
          return StyledText(
              text: AppLocalizations.of(context)!.add_movies_to_your_watchlist);
        }
        return MoviesPaginatedGrid(pagingController: _pagingController);
      },
    );
  }
}
