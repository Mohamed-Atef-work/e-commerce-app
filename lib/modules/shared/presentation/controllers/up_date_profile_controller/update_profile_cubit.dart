import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/update_user_data_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateUserDataUseCase _updateUseCase;

  UpdateProfileCubit(this._updateUseCase) : super(const UpdateProfileState());

  TextEditingController changedOne = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> updatePhone(CachedUserDataEntity params) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(updateState: RequestState.loading));

      final result = await _updateUseCase.call(params);
      emit(
        result.fold(
          (l) => state.copyWith(
              updateState: RequestState.error, message: l.message),
          (r) => state.copyWith(updateState: RequestState.success),
        ),
      );
    }
    print(state.updateState);
  }

  Future<void> updateName(CachedUserDataEntity params) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(updateState: RequestState.loading));

      final result = await _updateUseCase.call(params);

      Future.delayed(const Duration(milliseconds: 300), () {
        emit(
          result.fold(
            (l) => state.copyWith(
                updateState: RequestState.error, message: l.message),
            (r) => state.copyWith(updateState: RequestState.success),
          ),
        );
      });
    }
    print(state.updateState);
  }
}
/*  void userData(UserEntity userEntity) {
    emit(state.copyWith(userEntity: userEntity));
    name.text = state.userEntity!.name;
    phone.text = state.userEntity!.phone!;
    email.text = state.userEntity!.address!;
  }*/
