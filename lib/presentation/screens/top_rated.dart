import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../business_logic/cubit/top_movies_cubit.dart';
import '../../data/models/movie.dart';
import '../widgets/movies_paginated_grid.dart';

class TopRated extends StatefulWidget {
  final PageStorageKey key;
  TopRated({required this.key});

  @override
  _TopRatedState createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  final _pagingController = PagingController<int, Movie>(firstPageKey: 1);
  late TopMoviesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<TopMoviesCubit>();
    _setPaginationInitialState(_cubit);
    _pagingController.addPageRequestListener((pageKey) {
      _cubit.loadMovies(pageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  void _setPaginationInitialState(cubit) {
    final TopMoviesState cubitState = cubit.state;
    if (cubitState is TopMoviesLoaded) {
      _pagingController.value = PagingState(
        itemList: cubitState.movies,
        error: cubitState.error,
        nextPageKey: cubitState.nextPageKey,
      );
    } else if (cubitState is TopMoviesError) {
      _pagingController.error = cubitState.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TopMoviesCubit, TopMoviesState>(
      listener: (context, state) {
        if (state is TopMoviesError) {
          _pagingController.error = state.error;
        }
        if (state is TopMoviesLoaded) {
          _pagingController.value = PagingState(
            itemList: state.movies,
            error: null,
            nextPageKey: state.nextPageKey,
          );
        }
      },
      child: MoviesPaginatedGrid(pagingController: _pagingController),
    );
  }
}
