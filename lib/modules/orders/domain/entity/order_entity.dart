import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String name;
  final String phone;
  final String address;
  final double totalPrice;
  final List<ItemEntity> items;

  const OrderEntity({
    required this.name,
    required this.items,
    required this.phone,
    required this.address,
    required this.totalPrice,
  });

  @override
  List<Object?> get props => [
        totalPrice,
        phone,
        address,
        items,
        name,
      ];
}

class ItemEntity extends Equatable {
  final ProductEntity productEntity;
  final int quantity;

  const ItemEntity({
    required this.productEntity,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
        productEntity,
        quantity,
      ];
}
