import 'package:e_commerce_app/core/services/fire_store_services/favorite.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/add_delete_favorite_controller/add_delete_favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDeleteFavoriteCubit extends Cubit<AddDeleteFavoriteState> {
  final AddFavoriteUseCase addFavoriteUseCase;
  final DeleteFavoriteUseCase deleteFavoriteUseCase;
  AddDeleteFavoriteCubit(this.addFavoriteUseCase, this.deleteFavoriteUseCase)
      : super(const AddDeleteFavoriteState());

  Future<void> addOrDelete(AddDeleteFavoriteParams parameters) async {
    if (state.heartColor == Colors.red) {
      await deleteFavorite(parameters);
    } else {
      await addFavorite(parameters);
    }
  }

  void newProductHeart() {
    emit(state.copyWith(heartColor: Colors.white));
  }

  Future<void> addFavorite(AddDeleteFavoriteParams params) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await addFavoriteUseCase.call(params);
    emit(
      result.fold(
        (l) => state.copyWith(
            requestState: RequestState.error,
            heartColor: Colors.white,
            message: l.message),
        (r) => state.copyWith(
          requestState: RequestState.success,
          heartColor: Colors.red,
        ),
      ),
    );
  }

  Future<void> deleteFavorite(AddDeleteFavoriteParams params) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await deleteFavoriteUseCase.call(params);
    emit(
      result.fold(
        (l) => state.copyWith(
            requestState: RequestState.error,
            heartColor: Colors.red,
            message: l.message),
        (r) => state.copyWith(
          requestState: RequestState.success,
          heartColor: Colors.white,
        ),
      ),
    );
  }
}
