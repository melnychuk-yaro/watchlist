import 'package:watchlist/models/movie.dart';
import 'package:watchlist/services/movies_provider.dart';

class MoviesRepository {
  MoviesProvider _moviesProvider = MoviesProvider();
  Future<List<Movie>> getTopMovies() => _moviesProvider.getTopRatedMovies();
  Future<List<Movie>> getNewMovies() => _moviesProvider.getNewMovies();
  Future<List<Movie>> getFavMovies() => _moviesProvider.getFavMovies();
  Future<List<Movie>> searchMovies(query) =>
      _moviesProvider.searchMovies(query);
}
