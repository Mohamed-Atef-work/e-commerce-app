import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/save_address_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';
import 'package:meta/meta.dart';

part 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  final StoreUserDataUseCase _storeUserDataUseCase;
  final UpdateAddressUseCase _updateAddressUseCase;

  EditAddressCubit(this._storeUserDataUseCase, this._updateAddressUseCase)
      : super(const EditAddressState());

  TextEditingController city = TextEditingController();
  TextEditingController bloc = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController street = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void updateAddress(CachedUserDataEntity cashed) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(changeState: RequestState.loading));
      final result = await _updateAddressUseCase(cashed);
      emit(
        result.fold(
          (l) => state.copyWith(
              message: l.message, changeState: RequestState.error),
          (r) => state.copyWith(changeState: RequestState.success),
        ),
      );
      if (result.isRight()) {
        apartment.text = "";
        street.text = "";
        city.text = "";
        bloc.text = "";
      }
    }
  }
/* void updateAddress(UserModel user) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(changeState: RequestState.loading));
      final result = await _storeUserDataUseCase.call(UserModel(
        id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        address:
            "${city.text}, ${street.text}, ${bloc.text}, ${apartment.text}",
      ));

      */
/*

      emit(
        result.fold(
          (l) => state.copyWith(
              changeState: RequestState.error, message: l.message),
          (r) => state.copyWith(changeState: RequestState.success),
        ),
      );
    }
  }*/
}
