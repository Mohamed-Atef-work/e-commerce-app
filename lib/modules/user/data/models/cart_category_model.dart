import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/modules/user/domain/entities/cart_category_entity.dart';

class CartCategoryModel extends CartCategoryEntity {
  const CartCategoryModel({
    required super.reference,
    required super.id,
  });
  factory CartCategoryModel.fromJson({
    required DocumentReference reference,
    required String id,
  }) =>
      CartCategoryModel(
        reference: reference,
        id: id,
      );
}
