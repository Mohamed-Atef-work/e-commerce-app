import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/save_address_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:meta/meta.dart';

part 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  final UpdateAddressUseCase _updateAddressUseCase;

  EditAddressCubit(this._updateAddressUseCase)
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
    }
  }

  void clear() {
    apartment.text = "";
    street.text = "";
    city.text = "";
    bloc.text = "";
  }
}
