import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.product,
    required super.quantity,
  });
  factory OrderItemModel.fromJson({
    required String productId,
    required Map<String, dynamic> json,
  }) =>
      OrderItemModel(
        quantity: json["quantity"],
        product:
            ProductModel.formJson(productId: productId, json: json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "item": ProductModel(
          description: product.description,
          name: product.name,
          price: product.price,
          category: product.category,
          image: product.image,
          location: product.location,
          id: product.id,
        ).toJson(),
        "quantity": quantity,
      };
}
