import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/update_email.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

part 'change_email_state.dart';

class ChangeEmailCubit extends Cubit<ChangeEmailState> {
  final UpdateEmailUseCase _updateEmailUseCase;

  ChangeEmailCubit(this._updateEmailUseCase) : super(const ChangeEmailState());

  TextEditingController password = TextEditingController();
  TextEditingController newEmail = TextEditingController();
  TextEditingController oldEmail = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void obSecure() {
    emit(state.copyWith(obSecure: !state.obSecure));
  }

  void changeEmail(CachedUserDataEntity cachedUserData) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(changeState: RequestState.loading));

      final result = await _updateEmailUseCase.call(cachedUserData);
      emit(
        result.fold(
          (l) => state.copyWith(
              changeState: RequestState.error, message: l.message),
          (r) => state.copyWith(changeState: RequestState.success),
        ),
      );
    }
  }
}
