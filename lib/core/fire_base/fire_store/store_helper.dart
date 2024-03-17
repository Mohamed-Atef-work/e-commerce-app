import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/strings.dart';

abstract class StoreHelper {
  Future<bool> isProductExists(GetProductParams params);
  Future<DocumentSnapshot<Map<String, dynamic>>> getProduct(
      GetProductParams params);
  Future<QuerySnapshot<Map<String, dynamic>>> getProductsIdsOfCategory(
      DocumentReference reference);
}

class StoreHelperImpl implements StoreHelper {
  final FirebaseFirestore store;

  StoreHelperImpl(this.store);
  @override
  Future<bool> isProductExists(GetProductParams params) async {
    final response = await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.category)
        .doc(params.productId)
        .get();
    if (response.exists) {
      return true;
    }
    return false;
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getProduct(
      GetProductParams params) async {
    final response = await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.category)
        .doc(params.productId)
        .get();
    return response;
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getProductsIdsOfCategory(
      DocumentReference reference) async {
    final response = await reference.collection(kProducts).get();
    if (response.docs.isEmpty) {
      /// Solving the second part of database problem :) .....
      /// Deleting categories that doesn't contain [products] :) .....
      await reference.delete();
    }
    return response;
  }
}

class GetProductParams {
  final String category;
  final String productId;

  GetProductParams({
    required this.category,
    required this.productId,
  });
}

class GetProductOfCategoryParams {
  final List<String> ids;
  final String category;
  final String uId;

  GetProductOfCategoryParams({
    required this.ids,
    required this.uId,
    required this.category,
  });
}
