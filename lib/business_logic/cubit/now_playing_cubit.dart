import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:watchlist/business_logic/helpers/failure.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final MoviesRepository moviesRepository;
  NowPlayingCubit(this.moviesRepository) : super(NowPlayingInitial());

  Future<void> loadMovies(int page) async {
    try {
      final moviesPage =
          await moviesRepository.getNewMovies(page: state.nextPageKey);
      final updatedMovies = List<Movie>.from(state.movies)
        ..addAll(moviesPage.itemList);
      emit(NowPlayingLoaded(
        movies: updatedMovies,
        nextPageKey: moviesPage.isLastPage ? null : state.nextPageKey! + 1,
      ));
    } on Failure catch (f) {
      emit(NowPlayingInitial());
      emit(NowPlayingError(
        movies: state.movies,
        error: f.toString(),
        nextPageKey: state.nextPageKey,
      ));
    }
  }
}
