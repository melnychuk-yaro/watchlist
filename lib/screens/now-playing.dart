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
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MoviesInitialState) {
            return Center(
              child: Text(
                'No data. Please try again later.',
                style: TextStyle(fontSize: 20.0),
              ),
            );
          }

          if (state is MoviesErrorState) {
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

          if (state is MoviesLoadedState) {
            return GridView.builder(
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
      ),
    );
  }
}
