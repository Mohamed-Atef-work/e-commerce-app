import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  final StoreUserDataUseCase _storeUserDataUseCase;
  EditAddressCubit(this._storeUserDataUseCase)
      : super(const EditAddressState());

  TextEditingController city = TextEditingController();
  TextEditingController bloc = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController street = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> updateAddress() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(changeState: RequestState.loading));
      final result = await _storeUserDataUseCase.call(
        StoreUserDataParams(
          userModel: UserModel(
            id: "uId",
            name: "name",
            email: "email",
            phone: "phone",
            address:
                "${city.text}, ${street.text}, ${bloc.text}, ${apartment.text}",
          ),
        ),
      );

      if (result.isRight()) {
        apartment.text = "";
        street.text = "";
        city.text = "";
        bloc.text = "";
      }

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
