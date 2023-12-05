import 'package:flutter/material.dart';
import 'core/components/custom_text.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: TextButton(
          onPressed: () async {
            /*final ordersStore =
                OrderStoreServicesImpl(FirebaseFirestore.instance);
            ordersStore.addOrder(
              [
                {
                  "productOne": "One",
                },
                {
                  "productTwo": "Two",
                },
              ],
              {
                "name": "Mohamed",
                "address": "Al Sabaa",
                "phone": "01554465660",
                "totalPrice": "50",
              },
              "uId",
            );*/
          },
          child: const CustomText(text: "Add"),
        ),
      ),
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
      .collection(FirebaseStrings.products)
      .doc(FirebaseStrings.categories)
      .collection(category)
      .doc(productId)
      .get();
}*/
