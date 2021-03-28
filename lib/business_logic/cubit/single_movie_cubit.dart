import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watchlist/business_logic/helpers/failures/failure.dart';
import 'package:watchlist/data/models/movie_detailed.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

part 'single_movie_state.dart';

class SingleMovieCubit extends Cubit<SingleMovieState> {
  SingleMovieCubit(this.moviesRepository) : super(SingleMovieInitial());

  final MoviesRepository moviesRepository;

  Future<void> loadMovie(int movieId) async {
    emit(SingleMovieLoading());
    try {
      final MovieDetailed movie =
          await moviesRepository.getSingleMovie(id: movieId);
      emit(SingleMovieLoaded(movie));
    } on Failure catch (e) {
      emit(SingleMovieError(e.toString()));
    }
  }
}
