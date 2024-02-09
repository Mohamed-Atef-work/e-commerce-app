import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:meta/meta.dart';

part 'shared_password_state.dart';

class SharedPasswordCubit extends Cubit<SharedPasswordState> {
  final SharedDomainRepo _sharedDomainRepo;
  SharedPasswordCubit(this._sharedDomainRepo)
      : super(const SharedPasswordState());

  void savePassword(String password) async {
    emit(state.copyWith(saveState: RequestState.loading));

    final result = await _sharedDomainRepo.saveUserPasswordLocally(password);
    emit(
      result.fold(
        (l) =>
            state.copyWith(message: l.message, saveState: RequestState.error),
        (r) => state.copyWith(saveState: RequestState.success),
      ),
    );
  }

  void getPassword() async {
    emit(state.copyWith(getState: RequestState.loading));

    final result = await _sharedDomainRepo.getUserPasswordLocally();
    emit(
      result.fold(
        (l) =>
            state.copyWith(message: l.message, saveState: RequestState.error),
        (r) => state.copyWith(saveState: RequestState.success, password: r),
      ),
    );
  }

  void removePassword() async {
    emit(state.copyWith(deleteState: RequestState.loading));
    final result = await _sharedDomainRepo.deleteUserPasswordLocally();
    emit(
      result.fold(
        (l) =>
            state.copyWith(message: l.message, deleteState: RequestState.error),
        (r) => state.copyWith(deleteState: RequestState.success),
      ),
    );
  }
}
