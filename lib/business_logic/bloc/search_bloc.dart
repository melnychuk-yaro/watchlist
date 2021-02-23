import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/models/moviesPage.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final MoviesRepository moviesRepository;
  SearchBloc(this.moviesRepository) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchLoadEvent) {
      yield* _mapSearchLoadEvent(event);
    }

    if (event is SearchNextPageLoadEvent) {
      yield* _mapSearchNextPageLoadEvent(event);
    }

    if (event is SearchResetEvent) {
      yield SearchInitial(loadedMovies: List<Movie>());
    }
  }

  Stream<SearchState> _mapSearchLoadEvent(event) async* {
    if (event.query.trim() == '') {
      yield SearchInitial(loadedMovies: List<Movie>());
    } else if (event.query != state.query) {
      yield SearchLoading();
      try {
        final MoviesPage _moviesPage =
            await moviesRepository.searchMovies(query: event.query);

        final List<Movie> updatedMovies =
            List<Movie>.from(state.loadedMovies ?? List<Movie>())
              ..addAll(_moviesPage.itemList);
        yield SearchLoaded(
          loadedMovies: updatedMovies,
          nextPageKey: state.nextPageKey == null ? 2 : state.nextPageKey + 1,
          isLastPage: _moviesPage.isLastPage,
          query: event.query,
        );
      } catch (e) {
        print(e);
        yield SearchError(e);
      }
    }
  }

  Stream<SearchState> _mapSearchNextPageLoadEvent(event) async* {
    try {
      final MoviesPage _moviesPage = await moviesRepository.searchMovies(
          query: state.query, page: state.nextPageKey);
      final List<Movie> oldMovies = state.loadedMovies ?? [];
      yield SearchLoaded(
        loadedMovies: oldMovies + _moviesPage.itemList,
        nextPageKey: state.nextPageKey == null ? 2 : state.nextPageKey + 1,
        isLastPage: _moviesPage.isLastPage,
        query: state.query,
      );
    } catch (e) {
      print(e);
      yield SearchError(e);
    }
  }
}
