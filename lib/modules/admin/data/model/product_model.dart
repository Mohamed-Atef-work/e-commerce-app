import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.description,
    required super.category,
    required super.location,
    required super.image,
    required super.price,
    required super.name,
    required super.id,
  });
  Map<String, String> toJson() => {
        "productDescription": description,
        "productCategory": category,
        "productLocation": location,
        "productPrice": price,
        "productImage": image,
        "productName": name,
      };

  factory ProductModel.formJson(Map<String, dynamic> json,
          {required String productId}) =>
      ProductModel(
        description: json["productDescription"] ?? "",
        location: json["productLocation"] ?? "",
        category: json["productCategory"] ?? "",
        price: json["productPrice"] ?? "",
        image: json["productImage"] ?? "",
        name: json["productName"] ?? "",
        id: productId,
      );
}
