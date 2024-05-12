import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';

class UpDateOrderDataParams extends Equatable {
  final DocumentReference ref;
  final OrderDataModel data;

  const UpDateOrderDataParams({
    required this.ref,
    required this.data,
  });

  @override
  List<Object?> get props => [
        ref,
        data,
      ];
}
