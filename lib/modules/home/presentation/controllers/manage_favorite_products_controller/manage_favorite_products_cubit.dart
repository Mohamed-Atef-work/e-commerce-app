import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_favorites_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_favorite_products_controller/manage_favorite_products_state.dart';

class ManageFavoriteCubit extends Cubit<ManageFavoriteState> {
  final AddFavoriteUseCase addFavoriteUseCase;
  final GetFavoritesUseCase getFavoritesUseCase;
  final DeleteFavoriteUseCase deleteFavoriteUseCase;
  ManageFavoriteCubit(
    this.addFavoriteUseCase,
    this.deleteFavoriteUseCase,
    this.getFavoritesUseCase,
  ) : super(const ManageFavoriteState());

  /*void setHeartColor(Color heartColor) {
    emit(state.copyWith(heartColor: heartColor));
  }*/

  Future<void> getFavorites() async {
    if (state.needToReGet) {
      emit(state.copyWith(getFavState: RequestState.loading));

      /// Handling UID  :) ..........
      final result =
          await getFavoritesUseCase(const GetFavoritesParams(uId: "uId"));
      emit(
        result.fold(
          (l) => state.copyWith(
              message: l.message, getFavState: RequestState.error),
          (r) {
            List<ProductEntity> favorite = [];
            for (FavoriteEntity fav in r) {
              favorite.addAll(fav.products);
            }
            List<bool> isRed = List.generate(favorite.length, (index) => true);
            return state.copyWith(
              isRed: isRed,
              needToReGet: false,
              favorites: favorite,
              getFavState: RequestState.success,
            );
          },
        ),
      );
    }
  }

  Future<void> addOrDelete(AddDeleteFavoriteParams parameters,
      {required int index}) async {
    if (state.isRed[index]) {
      await deleteFavorite(parameters, index: index);
    } else {
      await addFavorite(parameters);
    }
  }

  Future<void> addFavorite(AddDeleteFavoriteParams params) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await addFavoriteUseCase.call(params);
    emit(
      result.fold(
        (l) => state.copyWith(
            requestState: RequestState.error, message: l.message),
        (r) => state.copyWith(
            needToReGet: true, requestState: RequestState.success),
      ),
    );
  }

  Future<void> deleteFavorite(AddDeleteFavoriteParams params,
      {required int index}) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await deleteFavoriteUseCase.call(params);
    emit(
      result.fold(
        (l) => state.copyWith(
            requestState: RequestState.error, message: l.message),
        (r) {
          state.isRed[index] = state.isRed[index];
          return state.copyWith(
              needToReGet: true, requestState: RequestState.success);
        },
      ),
    );
  }
}
