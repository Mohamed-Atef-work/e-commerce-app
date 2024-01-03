import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class OrderItemEntity extends Equatable {
  final ProductEntity product;
  final int quantity;

  const OrderItemEntity({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
        product,
        quantity,
      ];
}
