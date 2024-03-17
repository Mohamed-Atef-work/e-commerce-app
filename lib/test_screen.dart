import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

/*TextButton(
onPressed: () async {
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final ProductStore store = ProductStoreImpl(firestore);
await store.addProduct(
const AddProductparams(
product: ProductModel(
description: "productDescription",
location: "productLocation",
category: "suit shirts",
price: 20,
image: "productImage",
name: "productName"),
),
);
},
child: const CustomText(text: "Add"),
)*/

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
