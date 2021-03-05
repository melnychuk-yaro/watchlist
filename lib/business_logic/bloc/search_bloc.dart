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
      yield* _mapSearchLoadQueryEvent(event);
    }

    if (event is SearchNextPageLoadEvent) {
      yield* _mapSearchLoadNextPageEvent(event);
    }
  }

  Stream<SearchState> _mapSearchLoadQueryEvent(event) async* {
    if (event.query.trim() == '') {
      yield SearchInitial();
    } else if (event.query != state.query) {
      yield SearchLoading(
        query: event.query,
        loadedMovies: <Movie>[],
      );
      try {
        final MoviesPage moviesPage =
            await moviesRepository.searchMovies(query: event.query);
        yield SearchLoaded(
          loadedMovies: moviesPage.itemList,
          nextPageKey: moviesPage.isLastPage ? null : 2,
          query: event.query,
        );
      } catch (e) {
        print(e);
        yield SearchError(
          loadedMovies: state.loadedMovies,
          query: state.query,
          error: e.toString(),
          nextPageKey: state.nextPageKey,
        );
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
      yield SearchLoaded(
        loadedMovies: updatedMovies,
        nextPageKey: moviesPage.isLastPage ? null : state.nextPageKey ?? 0 + 1,
        query: state.query,
      );
    } catch (e) {
      print(e);
      yield SearchError(
        loadedMovies: state.loadedMovies,
        query: state.query,
        error: e.toString(),
        nextPageKey: state.nextPageKey,
      );
    }
  }
}
