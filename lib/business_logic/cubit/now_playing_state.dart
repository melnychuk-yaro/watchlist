part of 'now_playing_cubit.dart';

@immutable
abstract class NowPlayingState extends Equatable {
  const NowPlayingState({
    @required this.movies,
    @required this.error,
    @required this.nextPageKey,
    @required this.isLastPage,
  });

  final List<Movie> movies;
  final String error;
  final int nextPageKey;
  final bool isLastPage;

  @override
  List<Object> get props => [
        this.movies,
        this.error,
        this.nextPageKey,
        this.isLastPage,
      ];
}

class NowPlayingInitial extends NowPlayingState {
  NowPlayingInitial({
    @required this.movies,
    this.error = '',
    this.nextPageKey = 1,
    this.isLastPage = false,
  });

  final List<Movie> movies;
  final String error;
  final int nextPageKey;
  final bool isLastPage;
}

class NowPlayingLoaded extends NowPlayingState {
  const NowPlayingLoaded({
    @required this.movies,
    @required this.error,
    @required this.nextPageKey,
    @required this.isLastPage,
  });

  final List<Movie> movies;
  final String error;
  final int nextPageKey;
  final bool isLastPage;
}

class NowPlayingError extends NowPlayingState {
  const NowPlayingError({
    @required this.movies,
    @required this.error,
    @required this.nextPageKey,
    @required this.isLastPage,
  });

  final List<Movie> movies;
  final String error;
  final int nextPageKey;
  final bool isLastPage;
}
