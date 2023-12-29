import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';

class ItemModel extends ItemEntity {
  const ItemModel({
    required super.product,
    required super.quantity,
  });
  factory ItemModel.fromJson({
    required String productId,
    required Map<String, dynamic> json,
  }) =>
      ItemModel(
        quantity: int.parse(json["quantity"]),
        product: ProductModel.formJson(
          productId: productId,
          json["item"],
        ),
      );

  Map<String, dynamic> toJson() => {
        "item": product.toJson(),
        "quantity": quantity.toString(),
      };
}