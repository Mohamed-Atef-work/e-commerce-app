import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/services/fire_store_services/order.dart';
import 'package:e_commerce_app/modules/orders/data/data_source/order_remote_data_source.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/orders/data/repository/order_data_repository.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_user_orders_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/up_date_order_data_use_case.dart';
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
            final FirebaseFirestore firestore = FirebaseFirestore.instance;
            final OrderStore orderStore = OrderStoreImpl(firestore);
            final OrderBaseRemoteDataSource baseDataSource =
                OrderRemoteDataSource(orderStore);
            final OrderDomainRepo domainRepo = OrderDataRepo(baseDataSource);
            final GetUserOrdersUseCase getOrders =
                GetUserOrdersUseCase(domainRepo);
            // Add Order ---------------------> Done :) ;
            // Up data Order data ------------> Done :) ;
            // Add Order items ---------------> Done :) ;
            // Get Order items ---------------> Done :) ;
            // Get Order Data  ---------------> Done :) ;
            await getOrders.call("uId").then((result) async {
              result.fold((l) => null, (r) async {
                r.map((event) {
                  print(event.first.totalPrice);

                  UpDateOrderDataUseCase(domainRepo)
                      .call(
                    UpDateOrderDataParams(
                      ref: event.first.reference!,
                      data: OrderDataModel(
                        name: " Modified",
                        address: " Modified",
                        phone: " Modified",
                        totalPrice: " Modified",
                        date: DateTime.now().toString(),
                      ),
                    ),
                  )
                      .then((value) {
                    value.fold((l) {
                      print(l.message);
                    }, (r) {});
                  });
                }).toList();
              });
            });
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
