import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final int quantity;
  final ProductEntity product;
  final DocumentReference? ref;

  const OrderItemEntity({
    this.ref,
    required this.product,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
        ref,
        product,
        quantity,
      ];
}
