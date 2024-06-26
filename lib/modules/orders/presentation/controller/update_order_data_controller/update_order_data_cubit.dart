import 'package:flutter/cupertino.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/params/up_date_order_data_params.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';

part 'update_order_data_state.dart';

class UpdateOrderDataCubit extends Cubit<UpdateOrderDataState> {
  final OrderDomainRepo _orderRepo;

  //String? name;
  TextEditingController name = TextEditingController();
  //String? phone;
  TextEditingController phone = TextEditingController();
  //String? address;
  TextEditingController address = TextEditingController();

  final formKey = GlobalKey<FormState>();

  UpdateOrderDataCubit(this._orderRepo) : super(const UpdateOrderDataState());

  void orderData(OrderDataEntity orderData) {
    emit(state.copyWith(orderData: orderData));
    name.text = state.orderData!.name;
    phone.text = state.orderData!.phone;
    address.text = state.orderData!.address;
  }

  void updateOrderData() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(updateState: RequestState.loading));
      final orderDataModel = OrderDataModel(
        name: name.text,
        phone: phone.text,
        address: address.text,
        date: state.orderData!.date,
        totalPrice: state.orderData!.totalPrice,
      );
      final updateParams = UpDateOrderDataParams(
        ref: state.orderData!.reference!,
        data: orderDataModel,
      );

      final result = await _orderRepo.updateOrderData(updateParams);
      Future.delayed(
        const Duration(milliseconds: 300),
        () => emit(
          result.fold(
            (l) => state.copyWith(
                updateState: RequestState.error, message: l.message),
            (r) => state.copyWith(updateState: RequestState.success),
          ),
        ),
      );
    }
    print(state.updateState);
  }
}
