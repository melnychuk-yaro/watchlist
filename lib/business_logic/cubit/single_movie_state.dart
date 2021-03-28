part of 'single_movie_cubit.dart';

abstract class SingleMovieState extends Equatable {
  const SingleMovieState();

  @override
  List<Object> get props => [];
}

class SingleMovieInitial extends SingleMovieState {}

class SingleMovieLoading extends SingleMovieState {}

class SingleMovieLoaded extends SingleMovieState {
  SingleMovieLoaded(this.movie);
  final MovieDetailed movie;

  @override
  List<Object> get props => [movie];
}

class SingleMovieError extends SingleMovieState {
  SingleMovieError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
