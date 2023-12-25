import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/add_favorite_controller/add_favorite_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFavoriteCubit extends Cubit<AddFavoriteState> {
  final AddFavoriteUseCase addFavoriteUseCase;
  AddFavoriteCubit(this.addFavoriteUseCase) : super(const AddFavoriteState());

  Future<void> addFavorite(AddFavoriteParams params) async {
    emit(state.copyWith(addState: RequestState.loading));
    final result = await addFavoriteUseCase.call(params);
    emit(
      result.fold(
        (l) => state.copyWith(addState: RequestState.error, message: l.message),
        (r) => state.copyWith(addState: RequestState.success),
      ),
    );
  }
}
