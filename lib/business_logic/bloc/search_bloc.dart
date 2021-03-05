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
      yield SearchInitial();
    }
  }

  Stream<SearchState> _mapSearchLoadEvent(event) async* {
    if (event.query.trim() == '') {
      yield SearchInitial();
    } else if (event.query != state.query) {
      yield SearchLoading(
        query: event.query,
        loadedMovies: state.loadedMovies,
      );
      try {
        final MoviesPage moviesPage =
            await moviesRepository.searchMovies(query: event.query);
        final List<Movie> updatedMovies = List<Movie>.from(state.loadedMovies)
          ..addAll(moviesPage.itemList);
        yield SearchLoaded(
          loadedMovies: updatedMovies,
          nextPageKey:
              moviesPage.isLastPage ? null : state.nextPageKey ?? 0 + 1,
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

  Stream<SearchState> _mapSearchNextPageLoadEvent(event) async* {
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
