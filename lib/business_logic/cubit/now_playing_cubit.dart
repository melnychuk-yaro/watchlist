import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:watchlist/data/models/moviesPage.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'now_playing_state.dart';

class NowPlayingCubit extends Cubit<NowPlayingState> {
  final MoviesRepository moviesRepository;
  NowPlayingCubit(this.moviesRepository)
      : super(NowPlayingInitial(
          moviesPage: MoviesPage(itemList: [], isLastPage: false),
          error: null,
          nextPageKey: 1,
        ));

  void resetMovies() {
    emit(NowPlayingInitial(
      moviesPage: MoviesPage(itemList: [], isLastPage: false),
      error: null,
      nextPageKey: 1,
    ));
  }

  Future<void> loadMovies(int page) async {
    NowPlayingState _prevState = state;
    try {
      final moviesPage =
          await moviesRepository.getNewMovies(page: state.nextPageKey);
      emit(NowPlayingLoaded(
        moviesPage: moviesPage,
        error: null,
        nextPageKey: state.nextPageKey + 1,
      ));
    } catch (e) {
      emit(NowPlayingError(
          moviesPage: _prevState.moviesPage,
          error: e,
          nextPageKey: _prevState.nextPageKey));
    }
  }
}
