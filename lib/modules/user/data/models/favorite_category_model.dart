import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/modules/user/domain/entities/favorite_category_entity.dart';

class FavoriteCategoryModel extends FavoriteCategoryEntity {
  const FavoriteCategoryModel({
    required super.reference,
    required super.id,
  });
  factory FavoriteCategoryModel.fromJson({
    required DocumentReference reference,
    required String id,
  }) =>
      FavoriteCategoryModel(
        reference: reference,
        id: id,
      );
}
