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
        description: json["productDescription"],
        location: json["productLocation"],
        category: json["productCategory"],

        /// to do ----->
        price: json["productPrice"],
        image: json["productImage"],
        name: json["productName"],
        id: productId,
      );
  Map<String, dynamic> toJson() => {
        "productDescription": description,
        "productLocation": location,
        "productCategory": category,
        "productPrice": price,
        "productImage": image,
        "productName": name,
      };
}
