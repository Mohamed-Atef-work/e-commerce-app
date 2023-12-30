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
        description: json["Description"],
        location: json["Location"],
        category: json["Category"],
        price: json["Price"],
        image: json["Image"],
        name: json["Name"],
        id: productId,
      );
  Map<String, String> toJson() => {
        "Description": description,
        "Location": location,
        "Category": category,
        "Price": price,
        "Image": image,
        "Name": name,
      };
}
