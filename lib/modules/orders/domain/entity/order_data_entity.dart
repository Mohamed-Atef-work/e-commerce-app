import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class OrderDataEntity extends Equatable {
  final String name;
  final String phone;
  final String address;
  final String totalPrice;
  final DocumentReference reference;

  const OrderDataEntity({
    required this.name,
    required this.phone,
    required this.address,
    required this.reference,
    required this.totalPrice,
  });

  @override
  List<Object> get props => [
        name,
        phone,
        address,
        reference,
        totalPrice,
      ];
}
