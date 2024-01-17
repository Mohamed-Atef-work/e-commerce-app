import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';

class CartEntity extends Equatable {
  final List<ProductEntity> products;
  final String category;

  const CartEntity({
    required this.category,
    required this.products,
  });

  @override
  List<Object?> get props => [
        category,
        products,
      ];
}
