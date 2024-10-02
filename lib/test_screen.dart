import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'core/services/api/dio_services.dart';
import 'core/services/stripe/constants.dart';
import 'core/services/stripe/stripe_service.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {}
          /*{
            //final api = DioServices();
            //final stripe = StripeService(api);
            final dio = Dio();

            try {
              final response = await dio.post(
                "https://api.stripe.com/v1/ephemeral_keys",
                data: {kCustomer: StripeConstants.customerId},
                options: Options(
                  contentType: Headers.formUrlEncodedContentType,
                  headers: {
                    kStripeVersion: StripeConstants.version,
                    kAuthorization: "$kBearer ${StripeConstants.secretKey}",
                  },
                ),
              );
              print(response.data);
              print(response.statusCode);
              print(response.statusMessage);
            } catch (e) {
              print("error is ------>$e");
            }
            //await stripe.pay(100, "USD", StripeConstants.customerId);
          }*/,
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
      .collection(kProducts)
      .doc(kCategories)
      .collection(category)
      .doc(productId)
      .get();
}*/
