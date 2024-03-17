import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';

class OrderDataModel extends OrderDataEntity {
  const OrderDataModel({
    super.reference,
    required super.date,
    required super.name,
    required super.phone,
    required super.address,
    required super.totalPrice,
  });
  factory OrderDataModel.fromJson({
    required Map<String, dynamic> json,
    required DocumentReference orderRef,
  }) =>
      OrderDataModel(
        name: json[kName],
        date: json[kDate],
        phone: json[kPhone],
        address: json[kAddress],
        totalPrice: json[kTotalPrice],
        reference: orderRef,
      );
  Map<String, dynamic> toJson() => {
        kName: name,
        kDate: date,
        kPhone: phone,
        kAddress: address,
        kTotalPrice: totalPrice,
      };
}
