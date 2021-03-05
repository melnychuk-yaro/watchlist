import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'top_movies_state.dart';

class TopMoviesCubit extends Cubit<TopMoviesState> {
  final MoviesRepository moviesRepository;
  TopMoviesCubit(this.moviesRepository) : super(TopMoviesInitial());

  Future<void> loadMovies(int page) async {
    TopMoviesState prevState = state;
    try {
      final moviesPage =
          await moviesRepository.getTopRatedMovies(page: state.nextPageKey);
      final List<Movie> updatedMovies = List<Movie>.from(prevState.movies)
        ..addAll(moviesPage.itemList);
      emit(TopMoviesLoaded(
        movies: updatedMovies,
        nextPageKey: moviesPage.isLastPage ? null : prevState.nextPageKey! + 1,
      ));
    } catch (e) {
      emit(TopMoviesError(
        movies: prevState.movies,
        error: e.toString(),
        nextPageKey: prevState.nextPageKey,
      ));
    }
  }
}
