import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final StoreUserDataUseCase _storeUserDataUseCase;

  UpdateProfileCubit(this._storeUserDataUseCase)
      : super(const UpdateProfileState());

  //String? name;
  TextEditingController name = TextEditingController();
  //String? phone;
  TextEditingController phone = TextEditingController();
  //String? address;
  TextEditingController address = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void userData(UserEntity userEntity) {
    emit(state.copyWith(userEntity: userEntity));
    name.text = state.userEntity!.name;
    phone.text = state.userEntity!.phone!;
    address.text = state.userEntity!.address!;
  }

  Future<void> updateOrderData() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(updateState: RequestState.loading));

      final result = await _storeUserDataUseCase.call(
        StoreUserDataParams(
          userModel: UserModel(
            name: name.text,
            phone: phone.text,
            id: "uId",
            address: "address",
            email: "atef9463@gmail.com",
          ),
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
