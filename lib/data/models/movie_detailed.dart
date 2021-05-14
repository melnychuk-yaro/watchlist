import 'movie.dart';

class MovieDetailed extends Movie {
  final int id;
  final String title;
  final String releaseDate;
  final double rating;
  final String posterFileName;
  final String backgroundFileName;
  final String overview;
  final String tagline;
  final List<String> directors;
  final List<Map<String, dynamic>> genres;
  final int budget;
  final String youtubeVideoId;

  const MovieDetailed({
    required this.id,
    required this.title,
    required this.releaseDate,
    required this.posterFileName,
    required this.rating,
    required this.overview,
    required this.backgroundFileName,
    required this.tagline,
    required this.directors,
    required this.genres,
    required this.budget,
    required this.youtubeVideoId,
  }) : super(
          id: id,
          title: title,
          releaseDate: releaseDate,
          rating: rating,
          posterFileName: posterFileName,
        );

  String get fullBackgroundPath => Movie.posterPath + backgroundFileName;

  factory MovieDetailed.fromMap(Map<String, dynamic> movieMap) {
    bool isNull(val) => val == null || val == 'null' ? true : false;

    return MovieDetailed(
      id: movieMap['id'],
      title: movieMap['title'],
      releaseDate: movieMap['release_date'] ?? '',
      posterFileName:
          isNull(movieMap['poster_path']) ? '' : movieMap['poster_path'],
      backgroundFileName:
          isNull(movieMap['backdrop_path']) ? '' : movieMap['backdrop_path'],
      rating: isNull(movieMap['vote_average'])
          ? 0.0
          : movieMap['vote_average'].toDouble(),
      overview: isNull(movieMap['overview']) ? '' : movieMap['overview'],
      tagline: isNull(movieMap['tagline']) ? '' : movieMap['tagline'],
      directors: movieMap['directors'],
      genres: isNull(movieMap['genres'])
          ? []
          : movieMap['genres']
              .map<Map<String, dynamic>>(
                  (genre) => {'id': genre['id'], 'name': genre['name']})
              .toList(),
      budget: isNull(movieMap['budget']) ? 0 : movieMap['budget'],
      youtubeVideoId: movieMap['videoId'],
    );
  }
}
