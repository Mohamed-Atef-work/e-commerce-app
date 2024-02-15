import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_favorites_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/get_favorite_controller/get_favorite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetFavoriteCubit extends Cubit<GetFavoriteState> {
  final GetFavoritesUseCase getFavoritesUseCase;

  GetFavoriteCubit(this.getFavoritesUseCase) : super(const GetFavoriteState());
  void needToReGet() {
    emit(state.copyWith(needToReGet: true));
  }

  Future<void> getFavorites(String uId) async {
    if (state.needToReGet) {
      emit(state.copyWith(getFavState: RequestState.loading));
      final result = await getFavoritesUseCase(GetFavoritesParams(uId: uId));
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
