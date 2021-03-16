part of 'all_favorites_cubit.dart';

abstract class AllFavoritesState extends Equatable {
  final List<int> allFavoriteMovieIds;
  AllFavoritesState(this.allFavoriteMovieIds);

  @override
  List<Object> get props => [allFavoriteMovieIds];
}

class AllFavoritesInitial extends AllFavoritesState {
  AllFavoritesInitial() : super(<int>[]);
}

class AllFavoritesLoaded extends AllFavoritesState {
  final List<int> allFavoriteMovieIds;
  AllFavoritesLoaded(this.allFavoriteMovieIds) : super(allFavoriteMovieIds);
}
