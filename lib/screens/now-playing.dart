import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/bloc/movies_bloc.dart';
import 'package:watchlist/widgets/movie-card.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<MoviesBloc>(context).add(NewMoviesLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state is MoviesInitial) {
          return Center(
            child: Text(
              'No data. Please try again later.',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        if (state is MoviesError) {
          return Center(
            child: Text(
              'Something went wrong. Please try again later.',
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).errorColor,
              ),
            ),
          );
        }

        if (state is MoviesLoaded) {
          return GridView.builder(
            padding: const EdgeInsets.all(4.0),
            itemCount: state.loadedMovies.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300.0,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              return MovieCard(movie: state.loadedMovies[index]);
            },
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
