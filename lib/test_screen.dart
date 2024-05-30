
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/product.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
          },
          child: const CustomText(text: "Add"),
        ),
      ) ,
    );
  }
}



/*Future<List<DocumentSnapshot<Map<String, dynamic>>>>
    getFavoriteProductsOfCategory({
  required List<String> productIds,
  required String category,
}) async {
  List<DocumentSnapshot<Map<String, dynamic>>> products = [];

  for (int index = 0; index < productIds.length; index++) {
    print("in");
    final result = await _getFavoriteProduct(
        category: category, productId: productIds[index]);
    products.add(result);
  }
  return products;
}

Future<DocumentSnapshot<Map<String, dynamic>>> _getFavoriteProduct(
    {required String category, required String productId}) async {
  return await FirebaseFirestore.instance
      .collection(kProducts)
      .doc(kCategories)
      .collection(category)
      .doc(productId)
      .get();
}*/
