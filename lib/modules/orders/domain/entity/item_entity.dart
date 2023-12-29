import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final ProductModel product;
  final int quantity;

  const ItemEntity({
    required this.product,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
        product,
        quantity,
      ];
}
