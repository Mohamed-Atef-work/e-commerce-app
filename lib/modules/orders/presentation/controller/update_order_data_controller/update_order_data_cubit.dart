import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/up_date_order_data_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'update_order_data_state.dart';

class UpdateOrderDataCubit extends Cubit<UpdateOrderDataState> {
  final UpDateOrderDataUseCase _upDateOrderDataUseCase;

  String? name;
  String? phone;
  String? address;

  final formKey = GlobalKey<FormState>();

  UpdateOrderDataCubit(this._upDateOrderDataUseCase)
      : super(const UpdateOrderDataState());

  void orderData(OrderDataEntity orderData) {
    emit(state.copyWith(orderData: orderData));
  }

  Future<void> updateOrderData() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(updateState: RequestState.loading));

      final result = await _upDateOrderDataUseCase.call(
        UpDateOrderDataParams(
          ref: state.orderData!.reference!,
          data: OrderDataModel(
            name: name ?? state.orderData!.name,
            phone: phone ?? state.orderData!.phone,
            address: address ?? state.orderData!.address,
            date: state.orderData!.date,
            totalPrice: state.orderData!.totalPrice,
          ),
        ),
      );
      emit(result.fold(
        (l) =>
            state.copyWith(updateState: RequestState.error, message: l.message),
        (r) => state.copyWith(updateState: RequestState.success),
      ));
    }
    print(state.updateState);
  }
}
