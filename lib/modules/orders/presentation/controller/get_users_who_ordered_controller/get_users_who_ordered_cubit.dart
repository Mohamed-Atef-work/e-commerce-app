import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_users_who_ordered_use_case.dart';
import 'package:meta/meta.dart';

part 'get_users_who_ordered_state.dart';

class GetUsersWhoOrderedCubit extends Cubit<GetUsersWhoOrderedState> {
  final GetUsersWhoOrderedUseCase _getUsersWhoOrderedUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  GetUsersWhoOrderedCubit(
      this._getUsersWhoOrderedUseCase, this._getUserDataUseCase)
      : super(const GetUsersWhoOrderedState());

  StreamSubscription<List<String>>? idsSub;

  Future<void> getUsers() async {
    await idsSub?.cancel();
    emit(state.copyWith(usersDataState: RequestState.loading));
    final result = await _getUsersWhoOrderedUseCase(const NoParameters());

    result.fold(
        (l) => emit(
              state.copyWith(
                message: l.message,
                usersDataState: RequestState.error,
              ),
            ), (r) {
      idsSub = r.listen(
        (usersIds) {
          if (usersIds.isNotEmpty) {
            getUsersData(usersIds);
          } else {
            emit(
              state.copyWith(
                  usersDataState: RequestState.success, usersData: []),
            );
          }
        },
      );
    });
  }

  Future<void> getUsersData(List<String> ids) async {
    List<UserEntity> users = [];
    for (String id in ids) {
      final user =
          await _getUserDataUseCase.call(GetUserDataParameters(uId: id));
      user.fold(
          (l) => emit(
                state.copyWith(
                  message: l.message,
                  usersDataState: RequestState.error,
                ),
              ),
          (user) => users.add(user));
    }
    emit(
      state.copyWith(usersDataState: RequestState.success, usersData: users),
    );
  }

  @override
  Future<void> close() async {
    await idsSub?.cancel();
    return super.close();
  }
}
