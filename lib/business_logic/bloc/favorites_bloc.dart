import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/models/movie.dart';
import '../../data/repositories/movies_repository.dart';
import '../helpers/failures/failure.dart';
import 'auth_bloc.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final MoviesRepository moviesRepository;
  final AuthBloc authBloc;
  late StreamSubscription _authBlocSubscription;
  FavoritesBloc(this.moviesRepository, this.authBloc)
      : super(FavoritesState.initial(authBloc.state.user.id)) {
    add(FavoritesLoad());
    _authBlocSubscription = authBloc.stream.listen((authState) {
      if (authState.status == AuthStatus.authenticated) {
        add(FavoritesChangeUser(authState.user.id));
      }
    });
  }

  @override
  Future<void> close() {
    _authBlocSubscription.cancel();
    return super.close();
  }

  @override
  Stream<FavoritesState> mapEventToState(
    FavoritesEvent event,
  ) async* {
    if (event is FavoritesLoad) {
      yield* _favoritesLoad();
    } else if (event is FavoritesAdd) {
      yield* _favoritesAdd(event);
    } else if (event is FavoritesDelete) {
      yield* _favoritesDelete(event);
    } else if (event is FavoritesChangeUser) {
      yield* _favoritesChangeUser(event);
    }
  }

  Stream<FavoritesState> _favoritesChangeUser(event) async* {
    if (event.userId) yield FavoritesState.initial(event.userId);
    yield state.copyWith(status: FavoritesStatus.loading);
    yield* _favoritesLoad();
  }

  Stream<FavoritesState> _favoritesLoad() async* {
    try {
      final moviesPage = await moviesRepository.getFavMovies(
        userId: state.userId,
        lastDocument: state.lastDocumentSnapshot,
      );
      final updatedMovies = List<Movie>.from(state.loadedMovies)
        ..addAll(moviesPage.itemList);
      yield updatedMovies.isEmpty
          ? state.copyWith(
              status: FavoritesStatus.empty,
              loadedMovies: updatedMovies,
              nextPageKey: null,
              lastDocumentSnapshot: () => null,
            )
          : state.copyWith(
              status: FavoritesStatus.loaded,
              loadedMovies: updatedMovies,
              nextPageKey: () =>
                  moviesPage.isLastPage ? null : (state.nextPageKey ?? 1) + 1,
              lastDocumentSnapshot: () => moviesPage.lastDocumentSnapshot,
            );
    } on Failure catch (f) {
      yield FavoritesState.initial(state.userId);
      yield state.copyWith(
        status: FavoritesStatus.failure,
        error: f.toString(),
      );
    }
  }

  Stream<FavoritesState> _favoritesAdd(event) async* {
    yield state.copyWith(status: FavoritesStatus.loading);
    try {
      await moviesRepository.saveFavMovie(
        movie: event.movie,
        userId: state.userId,
      );
      final newMovies = List<Movie>.from(state.loadedMovies)
        ..insert(0, event.movie);
      yield state.copyWith(
        status: FavoritesStatus.loaded,
        loadedMovies: newMovies,
      );
    } on Failure catch (f) {
      yield FavoritesState.initial(state.userId);
      yield state.copyWith(
        status: FavoritesStatus.failure,
        error: f.toString(),
      );
    }
  }

  Stream<FavoritesState> _favoritesDelete(event) async* {
    yield state.copyWith(status: FavoritesStatus.loading);
    try {
      await moviesRepository.removeFavMovie(
        id: event.movieId,
        userId: state.userId,
      );
      final updatedMovies = List<Movie>.from(state.loadedMovies)
        ..removeWhere((movie) => movie.id == event.movieId);

      yield updatedMovies.isEmpty
          ? state.copyWith(
              status: FavoritesStatus.empty,
              loadedMovies: updatedMovies,
            )
          : state.copyWith(
              status: FavoritesStatus.loaded,
              loadedMovies: updatedMovies,
            );
    } on Failure catch (f) {
      yield FavoritesState.initial(state.userId);
      yield state.copyWith(
        status: FavoritesStatus.failure,
        error: f.toString(),
      );
    }
  }
}
