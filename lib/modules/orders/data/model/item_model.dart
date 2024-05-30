import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    super.ref,
    required super.product,
    required super.quantity,
  });
  factory OrderItemModel.fromJson({
    required String productId,
    required DocumentReference ref,
    required Map<String, dynamic> json,
  }) =>
      OrderItemModel(
        ref: ref,
        quantity: json[kQuantity],
        product: ProductModel.formJson(productId: productId, json: json[kItem]),
      );

  Map<String, dynamic> toJson() => {
        kItem: ProductModel(
          description: product.description,
          category: product.category,
          price: product.price,
          image: product.image,
          name: product.name,
          id: product.id,
        ).toJson(),
        kQuantity: quantity,
      };
}
