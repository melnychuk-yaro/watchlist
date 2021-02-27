import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:watchlist/business_logic/cubit/now_playing_cubit.dart';
import 'package:watchlist/data/models/movie.dart';
import 'package:watchlist/presentation/widgets/movies-paginated-grid.dart';

class NowPlaying extends StatefulWidget {
  final PageStorageKey key;
  NowPlaying({@required this.key});

  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  final _pagingController = PagingController<int, Movie>(firstPageKey: 1);
  NowPlayingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<NowPlayingCubit>();
    _setPaginationIntialState(_cubit);
    _pagingController.addPageRequestListener((pageKey) {
      _cubit.loadMovies(pageKey);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  void _setPaginationIntialState(cubit) {
    NowPlayingState cubitState = cubit.state;
    if (cubitState is NowPlayingLoaded) {
      _pagingController.value = PagingState(
        itemList: cubitState.movies,
        error: null,
        nextPageKey: cubitState.nextPageKey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NowPlayingCubit, NowPlayingState>(
      listener: (context, state) {
        if (state is NowPlayingError) {
          _pagingController.error = state.error;
        }
        if (state is NowPlayingLoaded) {
          _pagingController.value = PagingState(
            itemList: state.movies,
            error: null,
            nextPageKey: state.isLastPage ? null : state.nextPageKey,
          );
        }
      },
      child: MoviesPaginatedGrid(pagingController: _pagingController),
    );
  }
}
