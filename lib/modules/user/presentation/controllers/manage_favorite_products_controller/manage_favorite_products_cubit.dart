import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/user/domain/params/add_favorite_params.dart';
import 'package:e_commerce_app/modules/user/domain/repository/favorite_domain_repository.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/manage_favorite_products_controller/manage_favorite_products_state.dart';

class ManageFavoriteCubit extends Cubit<ManageFavoriteState> {
  final FavoriteDomainRepository _favRepo;
  ManageFavoriteCubit(
    this._favRepo,
  ) : super(const ManageFavoriteState());

  void setHeartColor(Color heartColor) {
    emit(state.copyWith(heartColor: heartColor));
  }

  void addOrDelete(AddDeleteFavoriteParams params) async {
    if (state.heartColor == Colors.red) {
      deleteFavorite(params);
    } else {
      addFavorite(params);
    }
  }

  void addFavorite(AddDeleteFavoriteParams params) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _favRepo.addFavorite(params);
    emit(
      result.fold(
        (l) => state.copyWith(
          message: l.message,
          requestState: RequestState.error,
        ),
        (r) => state.copyWith(
          heartColor: Colors.red,
          requestState: RequestState.success,
        ),
      ),
    );
  }

  void deleteFavorite(AddDeleteFavoriteParams params) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await _favRepo.deleteFavorite(params);
    emit(
      result.fold(
        (l) => state.copyWith(
          message: l.message,
          heartColor: Colors.red,
          requestState: RequestState.error,
        ),
        (r) => state.copyWith(
          heartColor: Colors.white,
          requestState: RequestState.success,
        ),
      ),
    );
  }
}
