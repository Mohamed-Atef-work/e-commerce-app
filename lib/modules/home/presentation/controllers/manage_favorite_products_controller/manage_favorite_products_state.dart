import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';

class ManageFavoriteState {
  final int? heartIndex;
  final String? message;
  final bool needToReGet;
  final List<bool> isRed;
  final RequestState getFavState;
  final RequestState requestState;
  final List<ProductEntity> favorites;

  const ManageFavoriteState({
    this.message,
    this.heartIndex,
    this.isRed = const [],
    this.needToReGet = true,
    this.favorites = const [],
    this.getFavState = RequestState.initial,
    this.requestState = RequestState.initial,
  });
  ManageFavoriteState copyWith({
    String? message,
    int? heartIndex,
    bool? needToReGet,
    List<bool>? isRed,
    RequestState? getFavState,
    RequestState? requestState,
    List<ProductEntity>? favorites,
  }) =>
      ManageFavoriteState(
        isRed: isRed ?? this.isRed,
        message: message ?? this.message,
        favorites: favorites ?? this.favorites,
        heartIndex: heartIndex ?? this.heartIndex,
        needToReGet: needToReGet ?? this.needToReGet,
        getFavState: getFavState ?? this.getFavState,
        requestState: requestState ?? this.requestState,
      );
}
