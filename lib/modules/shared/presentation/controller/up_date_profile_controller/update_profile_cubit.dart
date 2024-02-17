import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final StoreUserDataUseCase _storeUserDataUseCase;

  UpdateProfileCubit(this._storeUserDataUseCase)
      : super(const UpdateProfileState());

  TextEditingController changedOne = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> updatePhone(UserEntity user) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(updateState: RequestState.loading));

      final result = await _storeUserDataUseCase.call(
        UserModel(
          id: user.id,
          name: user.name,
          email: user.email,
          address: user.address,
          phone: changedOne.text,
        ),
      );
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

  Future<void> updateName(UserEntity user) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(updateState: RequestState.loading));

      final result = await _storeUserDataUseCase.call(
        UserModel(
          id: user.id,
          phone: user.phone,
          email: user.email,
          address: user.address,
          name: changedOne.text,
        ),
      );
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
}
/*  void userData(UserEntity userEntity) {
    emit(state.copyWith(userEntity: userEntity));
    name.text = state.userEntity!.name;
    phone.text = state.userEntity!.phone!;
    email.text = state.userEntity!.address!;
  }*/
