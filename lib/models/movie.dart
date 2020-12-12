class Movie {
  final int id;
  final String title;
  final String releaseDate;
  final String poster;
  final double rating;
  static const imgPath = 'https://image.tmdb.org/t/p/w500';

  Movie({
    this.id,
    this.title,
    this.releaseDate,
    this.poster,
    this.rating,
  });

  factory Movie.fromMap(Map<String, dynamic> movieMap) {
    Movie movie = Movie(
      id: movieMap['id'],
      title: movieMap['title'],
      releaseDate: movieMap['release_date'] ?? '',
      poster:
          movieMap['poster_path'] == null || movieMap['poster_path'] == 'null'
              ? 'https://critics.io/img/movies/poster-placeholder.png'
              : imgPath + movieMap['poster_path'],
      rating:
          movieMap['vote_average'] == null || movieMap['vote_average'] == 'null'
              ? 0.0
              : movieMap['vote_average'].toDouble(),
    );
    return movie;
  }
}
