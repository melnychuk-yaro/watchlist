import 'package:flutter/material.dart';
import 'package:watchlist/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  MovieCard({@required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(movie.poster),
            fit: BoxFit.cover,
          ),
        ),
        child: GridTile(
          child: Center(),
          footer: Container(
            color: Color(0xAA000000),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
