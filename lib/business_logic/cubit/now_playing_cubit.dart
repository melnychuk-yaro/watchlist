import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final MoviesRepository moviesRepository;
  NowPlayingCubit(this.moviesRepository) : super(NowPlayingInitial());

  Future<void> loadMovies(int page) async {
    NowPlayingState prevState = state;
    try {
      final moviesPage =
          await moviesRepository.getNewMovies(page: state.nextPageKey);
      final updatedMovies = List<Movie>.from(prevState.movies)
        ..addAll(moviesPage.itemList);
      emit(NowPlayingLoaded(
        movies: updatedMovies,
        nextPageKey: moviesPage.isLastPage ? null : prevState.nextPageKey! + 1,
      ));
    } catch (e) {
      NowPlayingInitial();
      emit(NowPlayingError(
        movies: prevState.movies,
        error: e.toString(),
        nextPageKey: prevState.nextPageKey,
      ));
    }
  }
}
