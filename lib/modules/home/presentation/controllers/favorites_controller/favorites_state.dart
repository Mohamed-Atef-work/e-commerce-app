part of 'favorites_cubit.dart';

@immutable
class FavoritesState {
  final String? message;
  final RequestState favState;
  //final RequestState categoriesState;
  final List<FavoriteEntity> favorites;

  const FavoritesState({
    this.message,
    this.favorites = const [],
    this.favState = RequestState.initial,
    //this.categoriesState = RequestState.initial,
  });
  FavoritesState copyWith({
    String? message,
    RequestState? favState,
    List<FavoriteEntity>? favorites,
    //RequestState? categoriesState,
  }) =>
      FavoritesState(
        message: message ?? this.message,
        favState: favState ?? this.favState,
        favorites: favorites ?? this.favorites,
        //categoriesState: categoriesState ?? this.categoriesState,
      );
}
