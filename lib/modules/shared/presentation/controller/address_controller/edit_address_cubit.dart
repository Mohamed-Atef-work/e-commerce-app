import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'edit_address_state.dart';

class EditAddressCubit extends Cubit<EditAddressState> {
  EditAddressCubit() : super(const EditAddressState());

  TextEditingController city = TextEditingController();
  TextEditingController apartment = TextEditingController();
  TextEditingController street = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Future<void> changePassword() async {}
}
