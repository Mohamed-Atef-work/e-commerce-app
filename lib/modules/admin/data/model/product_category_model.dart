import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';

class ProductCategoryModel extends ProductCategoryEntity {
  const ProductCategoryModel({
    required super.name,
    required super.id,
  });
  factory ProductCategoryModel.fromJson(Map<String, dynamic> json,{required String id,}) =>
      ProductCategoryModel(
        name: json[kName],
        id: id,
      );
}
