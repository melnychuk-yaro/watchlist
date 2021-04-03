import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/repositories/favorites_repository.dart';
import '../bloc/auth_bloc.dart';

part 'all_favorites_state.dart';

class AllFavoritesCubit extends Cubit<AllFavoritesState> {
  final FavoritesRepository moviesRepository;
  final AuthBloc authBloc;
  late StreamSubscription _authBlocSubscription;

  AllFavoritesCubit(this.moviesRepository, this.authBloc)
      : super(AllFavoritesInitial()) {
    loadFavMovies(authBloc.state.user.id);
    _authBlocSubscription = authBloc.stream.listen((authState) {
      emit(AllFavoritesInitial());
      if (authState.user.id != '') loadFavMovies(authState.user.id);
    });
  }

  Future<void> loadFavMovies(String uid) async {
    final favIds = await moviesRepository.getFavoritesIds(userId: uid);
    emit(AllFavoritesLoaded(favIds));
  }

  Future<void> addFavMovie(int uidmovieId) async {
    final favoriteMovieIds = List<int>.from(state.allFavoriteMovieIds)
      ..add(uidmovieId);
    emit(AllFavoritesLoaded(favoriteMovieIds));
  }

  Future<void> removeFavMovie(int uidmovieId) async {
    final favoriteMovieIds = List<int>.from(state.allFavoriteMovieIds)
      ..remove(uidmovieId);
    emit(AllFavoritesLoaded(favoriteMovieIds));
  }

  @override
  Future<void> close() {
    _authBlocSubscription.cancel();
    return super.close();
  }
}
