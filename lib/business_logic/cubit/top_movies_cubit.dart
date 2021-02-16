import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/data/models/moviesPage.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'top_movies_state.dart';

class TopMoviesCubit extends Cubit<TopMoviesState> {
  final MoviesRepository moviesRepository;
  TopMoviesCubit(this.moviesRepository)
      : super(TopMoviesInitial(
          moviesPage: MoviesPage(itemList: [], isLastPage: false),
          error: null,
          nextPageKey: 1,
        ));

  void resetMovies() {
    emit(TopMoviesInitial(
      moviesPage: MoviesPage(itemList: [], isLastPage: false),
      error: null,
      nextPageKey: 1,
    ));
  }

  Future<void> loadMovies(int page) async {
    TopMoviesState _prevState = state;
    try {
      final moviesPage =
          await moviesRepository.getTopRatedMovies(page: state.nextPageKey);
      emit(TopMoviesLoaded(
        moviesPage: moviesPage,
        error: null,
        nextPageKey: state.nextPageKey + 1,
      ));
    } catch (e) {
      emit(TopMoviesError(
          moviesPage: _prevState.moviesPage,
          error: e,
          nextPageKey: _prevState.nextPageKey));
    }
  }
}
