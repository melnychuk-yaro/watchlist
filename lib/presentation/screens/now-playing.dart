import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/business_logic/cubit/now_playing_cubit.dart';
import 'package:watchlist/presentation/widgets/paged-grid-view.dart';

class NowPlaying extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final NowPlayingCubit nowPlayingCubit =
        BlocProvider.of<NowPlayingCubit>(context);

    return PagedMoviesGridView(
      movCubit: nowPlayingCubit,
      loadMovies: nowPlayingCubit.loadMovies,
      resetMovies: nowPlayingCubit.resetMovies,
    );
  }
}
