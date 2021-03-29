import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/movie_detailed.dart';
import '../../data/repositories/movies_repository.dart';
import '../helpers/failures/failure.dart';

part 'single_movie_state.dart';

class SingleMovieCubit extends Cubit<SingleMovieState> {
  SingleMovieCubit(this.moviesRepository) : super(SingleMovieInitial());

  final MoviesRepository moviesRepository;

  Future<void> loadMovie(int movieId) async {
    emit(SingleMovieLoading());
    try {
      final movie = await moviesRepository.getSingleMovie(id: movieId);
      emit(SingleMovieLoaded(movie));
    } on Failure catch (e) {
      emit(SingleMovieError(e.toString()));
    }
  }
}
