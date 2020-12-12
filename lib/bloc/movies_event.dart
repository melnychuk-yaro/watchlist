part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent {}

class TopMoviesLoadEvent extends MoviesEvent {}

class NewMoviesLoadEvent extends MoviesEvent {}
