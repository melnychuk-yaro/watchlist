import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final MoviesRepository moviesRepository;
  NowPlayingCubit(this.moviesRepository)
      : super(NowPlayingInitial(movies: List<Movie>()));

  void resetMovies() {
    emit(NowPlayingInitial(movies: List<Movie>()));
  }

  Future<void> loadMovies(int page) async {
    NowPlayingState _prevState = state;
    try {
      final moviesPage = await moviesRepository.getNewMovies(
        page: state.nextPageKey,
      );
      final List<Movie> updatedMovies = List<Movie>.from(_prevState.movies)
        ..addAll(moviesPage.itemList);
      emit(NowPlayingLoaded(
        movies: updatedMovies,
        error: '',
        nextPageKey: _prevState.nextPageKey + 1,
        isLastPage: moviesPage.isLastPage,
      ));
    } catch (e) {
      NowPlayingInitial(movies: List<Movie>());
      emit(NowPlayingError(
        movies: _prevState.movies,
        error: 'Something went wrong',
        nextPageKey: _prevState.nextPageKey,
        isLastPage: _prevState.isLastPage,
      ));
    }
  }
}
