import 'package:flutter/material.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/data/repositories/movies_repository.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final MoviesRepository moviesRepository = MoviesRepository();
  MovieCard({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: movie.posterFileName == ''
                    ? AssetImage('assets/images/dark-gray-bg.jpg')
                    : NetworkImage(movie.fullPosterPath),
                fit: BoxFit.cover,
              ),
            ),
            child: GridTile(
              child: Center(),
              footer: Container(
                color: Color(0xAA000000),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Chip(
                label: Text('${movie.rating}'),
              ),
              IconButton(
                onPressed: () => moviesRepository.saveFavMovie(movie),
                icon: Icon(
                  movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
