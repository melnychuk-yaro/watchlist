import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/data/models/movie.dart';
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
      yield SearchLoading();
      try {
        final List<Movie> _loadedSearchList =
            await moviesRepository.searchMovies(event.query);
        yield SearchLoaded(loadedMovies: _loadedSearchList);
      } catch (e) {
        yield SearchError();
      }
    }
  }
}
