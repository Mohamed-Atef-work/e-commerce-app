import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/init_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/get_initial_use_case.dart';
import 'package:meta/meta.dart';

part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  final GetInitialDataUseCase _GetInitialDataUseCase;
  InitCubit(this._GetInitialDataUseCase) : super(const InitState());

  void init() async {
    emit(state.copyWith(dataState: RequestState.loading));
    final result = await _GetInitialDataUseCase(const NoParameters());
    emit(
      result.fold(
        (l) =>
            state.copyWith(dataState: RequestState.error, message: l.message),
        (r) => state.copyWith(dataState: RequestState.success, initEntity: r),
      ),
    );
  }
}
