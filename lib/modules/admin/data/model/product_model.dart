import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.description,
    required super.category,
    required super.location,
    required super.image,
    required super.price,
    required super.name,
    super.id,
  });

  factory ProductModel.formJson(
          {required Map<String, dynamic> json, required String productId}) =>
      ProductModel(
        description: json[kDescription],
        location: json[kLocation],
        category: json[kCategory],

        /// to do ----->
        price: json[kPrice],
        image: json[kImage],
        name: json[kName],
        id: productId,
      );
  Map<String, dynamic> toJson() => {
        kDescription: description,
        kLocation: location,
        kCategory: category,
        kPrice: price,
        kImage: image,
        kName: name,
      };
}
