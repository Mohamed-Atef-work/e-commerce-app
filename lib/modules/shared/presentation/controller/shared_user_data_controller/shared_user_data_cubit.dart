import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/get_initial_use_case.dart';
import 'package:e_commerce_app/modules/shared/presentation/controller/shared_user_data_controller/shared_user_data_state.dart';

class SharedUserDataCubit extends Cubit<SharedUserDataState> {
  final SharedDomainRepo _sharedDomainRepo;
  final GetInitialDataUseCase _getInitialDataUseCase;

  SharedUserDataCubit(
    this._sharedDomainRepo,
    this._getInitialDataUseCase,
  ) : super(const SharedUserDataState());

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

    final result = await _getInitialDataUseCase.call(const NoParameters());
    emit(
      result.fold(
        (l) =>
            state.copyWith(message: l.message, getState: RequestState.error),
        (r) => state.copyWith(getState: RequestState.success, initEntity: r),
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
