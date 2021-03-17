import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/business_logic/helpers/failure.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/models/moviesPage.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MoviesRepository moviesRepository;
  SearchBloc(this.moviesRepository) : super(SearchState.initial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchLoadEvent) {
      yield* _mapSearchLoadFisrstPageEvent(event);
    }

    if (event is SearchNextPageLoadEvent) {
      yield* _mapSearchLoadNextPageEvent(event);
    }
  }

  Stream<SearchState> _mapSearchLoadFisrstPageEvent(event) async* {
    if (event.query.trim() == '') {
      yield SearchState.initial();
    } else if (event.query != state.query) {
      yield state.copyWith(status: SearchStatus.loading);
      try {
        final MoviesPage moviesPage =
            await moviesRepository.searchMovies(query: event.query);
        yield state.copyWith(
          status: SearchStatus.loaded,
          loadedMovies: moviesPage.itemList,
          nextPageKey: () => moviesPage.isLastPage ? null : 2,
          query: event.query,
        );
      } on Failure catch (f) {
        yield SearchState.initial();
        yield state.copyWith(status: SearchStatus.failure, error: f.toString());
      }
    }
  }

  Stream<SearchState> _mapSearchLoadNextPageEvent(event) async* {
    try {
      final MoviesPage moviesPage = await moviesRepository.searchMovies(
        query: state.query,
        page: state.nextPageKey ?? 1,
      );
      final List<Movie> updatedMovies = List<Movie>.from(state.loadedMovies)
        ..addAll(moviesPage.itemList);
      yield state.copyWith(
        status: SearchStatus.loaded,
        loadedMovies: updatedMovies,
        nextPageKey: () =>
            moviesPage.isLastPage ? null : (state.nextPageKey ?? 1) + 1,
      );
    } on Failure catch (f) {
      yield SearchState.initial();
      yield state.copyWith(status: SearchStatus.failure, error: f.toString());
    }
  }
}
