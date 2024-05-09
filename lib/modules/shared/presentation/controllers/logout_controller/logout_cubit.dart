import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/log_out_use_case.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase _logoutUseCase;
  LogoutCubit(this._logoutUseCase) : super(LogoutState());
  void logout() async {
    emit(state.copyWith(logoutState: RequestState.loading));
    final result = await _logoutUseCase.call(const NoParams());
    emit(
      result.fold(
        (l) =>
            state.copyWith(logoutState: RequestState.error, message: l.message),
        (r) => state.copyWith(logoutState: RequestState.success),
      ),
    );
  }
}
