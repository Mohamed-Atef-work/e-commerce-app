import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';

class ProductWithQuantityEntity {
  final ProductEntity product;
  final int quantity;

  ProductWithQuantityEntity({
    required this.product,
    required this.quantity,
  });
}