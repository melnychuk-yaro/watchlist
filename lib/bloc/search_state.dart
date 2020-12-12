part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<dynamic> loadedMovies;
  SearchLoaded({@required this.loadedMovies}) : assert(loadedMovies != null);
}

class SearchError extends SearchState {}
