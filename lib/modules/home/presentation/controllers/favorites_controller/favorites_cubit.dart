import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/home/domain/home_use_cases/get_favorites_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/repository/favorite_domain_repository.dart';
import 'package:meta/meta.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final GetFavoritesUseCase getFavoritesUseCase;
  FavoritesCubit(this.getFavoritesUseCase) : super(const FavoritesState());
  Future<void> getFavorites() async {
    emit(state.copyWith(favState: RequestState.loading));
    final result =
        await getFavoritesUseCase(const GetFavoritesParams(uId: "uId"));
    emit(
      result.fold(
        (l) => state.copyWith(message: l.message, favState: RequestState.error),
        (r) => state.copyWith(favState: RequestState.success, favorites: r),
      ),
    );
  }
}
