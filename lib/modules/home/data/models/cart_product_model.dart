import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_product_entity.dart';

class CartProductModel extends CartProductEntity {
  const CartProductModel({required super.quantity, required super.products});

  factory CartProductModel.fromJson({
    required String id,
    required int quantity,
    required Map<String, dynamic> json,
  }) =>
      CartProductModel(
          quantity: quantity,
          products: ProductModel.formJson(json: json, productId: id));
}
