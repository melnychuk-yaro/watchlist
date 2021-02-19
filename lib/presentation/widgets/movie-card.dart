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
                visualDensity: VisualDensity.compact,
                label: Text('${movie.rating}'),
              ),
              AddToFavButton(
                movie: movie,
                moviesRepository: moviesRepository,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AddToFavButton extends StatefulWidget {
  const AddToFavButton({
    Key key,
    @required this.movie,
    @required this.moviesRepository,
  }) : super(key: key);

  final Movie movie;
  final MoviesRepository moviesRepository;

  @override
  _AddToFavButtonState createState() => _AddToFavButtonState();
}

class _AddToFavButtonState extends State<AddToFavButton> {
  bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.movie.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        isFavorite
            ? widget.moviesRepository.removeFavMovie(widget.movie.id)
            : widget.moviesRepository.saveFavMovie(widget.movie);
        setState(() => isFavorite = !isFavorite);
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
    );
  }
}
