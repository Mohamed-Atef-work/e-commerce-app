import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_categories_entity.dart';

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
