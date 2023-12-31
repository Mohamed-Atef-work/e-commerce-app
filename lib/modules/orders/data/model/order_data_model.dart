import 'package:cloud_firestore/cloud_firestore.dart';
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
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        totalPrice: json["totalPrice"],
        date: json["date"],
        reference: orderRef,
      );
  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "date": date,
        "address": address,
        "totalPrice": totalPrice,
      };
}
