import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CartProductEntity extends Equatable {
  final ProductEntity products;
  final int quantity;

  const CartProductEntity({
    required this.quantity,
    required this.products,
  });

  @override
  List<Object?> get props => [
        quantity,
        products,
      ];
}
