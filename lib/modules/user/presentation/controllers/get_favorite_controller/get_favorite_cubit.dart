import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/user/domain/params/get_favorites_params.dart';
import 'package:e_commerce_app/modules/user/domain/repository/favorite_domain_repository.dart';
import 'package:e_commerce_app/modules/user/presentation/controllers/get_favorite_controller/get_favorite_state.dart';

class GetFavoriteCubit extends Cubit<GetFavoriteState> {
  final FavoriteDomainRepository _favRepo;

  GetFavoriteCubit(this._favRepo) : super(const GetFavoriteState());
  void needToReGet() {
    emit(state.copyWith(needToReGet: true));
  }

  Future<void> getFavorites(String uId) async {
    if (state.needToReGet) {
      emit(state.copyWith(getFavState: RequestState.loading));
      final result = await _favRepo.getFavorites(GetFavoritesParams(uId: uId));
      emit(
        result.fold(
          (l) => state.copyWith(
              message: l.message, getFavState: RequestState.error),
          (r) => state.copyWith(
              favorites: r,
              needToReGet: false,
              getFavState: RequestState.success),
        ),
      );
    }
  }
}
