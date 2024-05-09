import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/user/domain/entities/favorite_entity.dart';
import 'package:equatable/equatable.dart';

class GetFavoriteState extends Equatable {
  final String message;
  final bool needToReGet;
  final RequestState getFavState;
  final List<FavoriteEntity> favorites;

  const GetFavoriteState({
    this.message = "",
    this.needToReGet = true,
    this.getFavState = RequestState.initial,
    this.favorites = const [],
  });

  GetFavoriteState copyWith({
    String? message,
    bool? needToReGet,
    RequestState? getFavState,
    List<FavoriteEntity>? favorites,
  }) =>
      GetFavoriteState(
        message: message ?? this.message,
        favorites: favorites ?? this.favorites,
        needToReGet: needToReGet ?? this.needToReGet,
        getFavState: getFavState ?? this.getFavState,
      );

  @override
  List<Object?> get props => [
        message,
        needToReGet,
        getFavState,
        favorites,
      ];
}
