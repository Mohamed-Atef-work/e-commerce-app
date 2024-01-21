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
        description: json["description"],
        location: json["location"],
        category: json["category"],

        /// to do ----->
        price: json["price"],
        image: json["image"],
        name: json["name"],
        id: productId,
      );
  Map<String, dynamic> toJson() => {
        "description": description,
        "location": location,
        "category": category,
        "price": price,
        "image": image,
        "name": name,
      };
}
