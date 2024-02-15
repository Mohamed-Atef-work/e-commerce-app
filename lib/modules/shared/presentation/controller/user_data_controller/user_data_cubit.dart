import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/get_initial_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/user_data_after_login_use_case.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/user_data_controller/user_data_state.dart';

class SharedUserDataCubit extends Cubit<SharedUserDataState> {
  final SharedDomainRepo _sharedDomainRepo;
  final GetInitialDataUseCase _getInitialDataUseCase;
  final UserDataAfterLoginUseCase _userDataAfterLoginUseCase;

  SharedUserDataCubit(
    this._sharedDomainRepo,
    this._getInitialDataUseCase,
    this._userDataAfterLoginUseCase,
  ) : super(const SharedUserDataState());

  void userDataAfterLogin(AfterLoginParams params) async {
    emit(state.copyWith(afterLoginState: RequestState.loading));
    final result = await _userDataAfterLoginUseCase(params);
    emit(
      result.fold(
        (l) => state.copyWith(
            afterLoginState: RequestState.error, message: l.message),
        (r) => state.copyWith(
            afterLoginState: RequestState.success, sharedEntity: r),
      ),
    );
  }

  void getInitialDataLocally() async {
    emit(state.copyWith(getState: RequestState.loading));

    final result = await _getInitialDataUseCase.call(const Noparams());
    emit(
      result.fold(
        (l) => state.copyWith(message: l.message, getState: RequestState.error),
        (r) => state.copyWith(getState: RequestState.success, sharedEntity: r),
      ),
    );
  }

  void saveDataLocally(CachedUserDataModel user) async {
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

  void removeData() async {
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
