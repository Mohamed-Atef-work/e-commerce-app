import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/manage_favorite_products_controller/manage_favorite_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManageFavoriteCubit extends Cubit<ManageFavoriteState> {
  final AddFavoriteUseCase addFavoriteUseCase;
  final DeleteFavoriteUseCase deleteFavoriteUseCase;
  ManageFavoriteCubit(
    this.addFavoriteUseCase,
    this.deleteFavoriteUseCase,
  ) : super(const ManageFavoriteState());

  void setHeartColor(Color heartColor) {
    emit(state.copyWith(heartColor: heartColor));
  }

  Future<void> addOrDelete(AddDeleteFavoriteParams parameters) async {
    if (state.heartColor == Colors.red) {
      await deleteFavorite(parameters);
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
          requestState: RequestState.error,
          message: l.message,
        ),
        (r) => state.copyWith(
          heartColor: Colors.red,
          requestState: RequestState.success,
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
          message: l.message,
        ),
        (r) => state.copyWith(
          heartColor: Colors.white,
          requestState: RequestState.success,
        ),
      ),
    );
  }
}
