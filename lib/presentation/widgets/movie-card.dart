import 'package:flutter/material.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/presentation/widgets/add-to-fav-button.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final Key key;
  MovieCard({required this.movie, required this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Brightness _brightness = MediaQuery.of(context).platformBrightness;

    return Stack(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: movie.posterFileName == ''
                    ? AssetImage('assets/images/dark-gray-bg.jpg')
                    : NetworkImage(movie.fullPosterPath) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
            child: GridTile(
              child: Center(),
              footer: Container(
                color: _brightness == Brightness.light
                    ? Color(0xEEFAFAFA)
                    : Color(0xEE303030),
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
                visualDensity: VisualDensity.compact,
                label: Text('${movie.rating}'),
              ),
              AddToFavButton(
                key: ValueKey(movie.id),
                movie: movie,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
