import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/shared_user_data_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/get_initial_use_case.dart';
import 'package:meta/meta.dart';


/*class InitCubit extends Cubit<InitState> {
  final GetInitialDataUseCase _getInitialDataUseCase;
  InitCubit(this._getInitialDataUseCase) : super(const InitState());

  void init() async {
    emit(state.copyWith(dataState: RequestState.loading));
    final result = await _getInitialDataUseCase(const NoParams());
    emit(
      result.fold(
        (l) =>
            state.copyWith(dataState: RequestState.error, message: l.message),
        (r) => state.copyWith(dataState: RequestState.success, SharedUserDataEntity: r),
      ),
    );
  }
}*/
