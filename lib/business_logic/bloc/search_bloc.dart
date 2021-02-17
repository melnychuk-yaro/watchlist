import 'dart:async';

import 'package:bloc/bloc.dart';
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
      if (event.query.trim() == '') {
        yield SearchInitial();
      } else {
        yield SearchLoading();
        try {
          final MoviesPage _moviesPage =
              await moviesRepository.searchMovies(query: event.query);
          yield SearchLoaded(
            loadedMovies: _moviesPage.itemList,
            nextPageKey: state.nextPageKey == null ? 1 : state.nextPageKey + 1,
            isLastPage: _moviesPage.isLastPage,
            query: event.query,
          );
        } catch (e) {
          print(e);
          yield SearchError(e);
        }
      }
    }

    if (event is SearchNextPageLoadEvent) {
      try {
        final MoviesPage _moviesPage = await moviesRepository.searchMovies(
            query: state.query, page: state.nextPageKey);
        yield SearchLoaded(
          loadedMovies: _moviesPage.itemList,
          nextPageKey: state.nextPageKey == null ? 1 : state.nextPageKey + 1,
          isLastPage: _moviesPage.isLastPage,
          query: state.query,
        );
      } catch (e) {
        print(e);
        yield SearchError(e);
      }
    }
  }
}
