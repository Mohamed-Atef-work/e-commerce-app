import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_users_who_ordered_use_case.dart';
import 'package:meta/meta.dart';

part 'get_users_who_ordered_state.dart';

class GetUsersWhoOrderedCubit extends Cubit<GetUsersWhoOrderedState> {
  final GetUsersWhoOrderedUseCase _getUsersWhoOrderedUseCase;
  GetUsersWhoOrderedCubit(this._getUsersWhoOrderedUseCase)
      : super(const GetUsersWhoOrderedState());

  StreamSubscription<List<String>>? idsSub;
  StreamSubscription<List<UserEntity>>? idsSubTwo;

  Future<void> getUsersTwo() async {
    await idsSubTwo?.cancel();
    emit(state.copyWith(usersDataState: RequestState.loading));
    final result = await _getUsersWhoOrderedUseCase(const NoParameters());

    result.fold(
        (l) => emit(
              state.copyWith(
                message: l.message,
                usersDataState: RequestState.error,
              ),
            ), (r) {
      idsSubTwo = r.listen((event) {
        emit(
          state.copyWith(
            usersData: event,
            usersDataState: RequestState.success,
          ),
        );
      });
    });
  }

  @override
  Future<void> close() async {
    await idsSub?.cancel();
    return super.close();
  }
}
