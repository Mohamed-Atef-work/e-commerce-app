import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

part 'shared_user_data_state.dart';

class SharedUserDataCubit extends Cubit<SharedUserDataState> {
  final SharedDomainRepo _sharedDomainRepo;
  SharedUserDataCubit(this._sharedDomainRepo)
      : super(const SharedUserDataState());
  void saveData(CachedUserDataModel user) async {
    emit(state.copyWith(saveState: RequestState.loading));

    final result = await _sharedDomainRepo.saveUserDataLocally(user);
    emit(
      result.fold(
        (l) =>
            state.copyWith(message: l.message, saveState: RequestState.error),
        (r) => state.copyWith(saveState: RequestState.success),
      ),
    );
  }

  void getData() async {
    emit(state.copyWith(getState: RequestState.loading));

    final result = await _sharedDomainRepo.getUserDataLocally();
    emit(
      result.fold(
        (l) =>
            state.copyWith(message: l.message, saveState: RequestState.error),
        (r) => state.copyWith(saveState: RequestState.success, user: r),
      ),
    );
  }

  void removeData(UserModel user) async {
    emit(state.copyWith(deleteState: RequestState.loading));

    final result = await _sharedDomainRepo.deleteUserDataLocally();
    emit(
      result.fold(
        (l) =>
            state.copyWith(message: l.message, deleteState: RequestState.error),
        (r) => state.copyWith(deleteState: RequestState.success),
      ),
    );
  }
}
