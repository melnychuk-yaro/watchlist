import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'top_movies_state.dart';

class TopMoviesCubit extends Cubit<TopMoviesState> {
  final MoviesRepository moviesRepository;
  TopMoviesCubit(this.moviesRepository)
      : super(TopMoviesInitial(movies: List<Movie>()));

  void resetMovies() {
    emit(TopMoviesInitial(movies: List<Movie>()));
  }

  Future<void> loadMovies(int page) async {
    TopMoviesState _prevState = state;
    try {
      final moviesPage =
          await moviesRepository.getTopRatedMovies(page: state.nextPageKey);
      final List<Movie> updatedMovies = List<Movie>.from(_prevState.movies)
        ..addAll(moviesPage.itemList);
      emit(TopMoviesLoaded(
        movies: updatedMovies,
        error: '',
        nextPageKey: _prevState.nextPageKey + 1,
        isLastPage: moviesPage.isLastPage,
      ));
    } catch (e) {
      emit(TopMoviesError(
        movies: _prevState.movies,
        error: 'Something went wrong',
        nextPageKey: _prevState.nextPageKey,
        isLastPage: _prevState.isLastPage,
      ));
    }
  }
}
