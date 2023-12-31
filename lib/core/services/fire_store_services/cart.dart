import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utils/fire_base_strings.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';

abstract class CartStore {
  Future<void> addToCart(AddToCartParams params);
  Future<void> deleteFromCart(DeleteFromCartParams params);
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getCartProducts(
      String uId);

  /// < ---------------------------------------------------------------------- >
  Future<List<DocumentReference>> getCartCategories(String uId);
  Future<ReturnedIdsAndTheirCategory> getCategoryIds(
      DocumentReference categoryRef);
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getProductsOfCategory(
      GetProductsOfOneCategoryParams params);
  Future<QuerySnapshot<Map<String, dynamic>>> getCartProductsIdsOfCategory(
      DocumentReference reference);
  Future<DocumentSnapshot<Map<String, dynamic>>> getProduct(
      GetProductParams params);
}

class CartStoreImpl implements CartStore {
  final FirebaseFirestore store;

  CartStoreImpl(this.store);
  @override
  Future<void> addToCart(AddToCartParams params) async {
    await store
        .collection(FirebaseStrings.users)
        .doc(params.uId)
        .collection(FirebaseStrings.cart)
        .doc(params.category)
        .collection(FirebaseStrings.products)
        .doc(params.productId)
        .set(const {});
    await _setCartCategoryToBeAvailableToFetch(params);
  }

  @override
  Future<void> deleteFromCart(DeleteFromCartParams params) async {
    await store
        .collection(FirebaseStrings.users)
        .doc(params.uId)
        .collection(FirebaseStrings.cart)
        .doc(params.category)
        .collection(FirebaseStrings.products)
        .doc(params.productId)
        .delete();
  }

  @override
  Future<List<DocumentReference>> getCartCategories(String uId) async {
    List<DocumentReference> docsRefs = [];
    final response = await store
        .collection(FirebaseStrings.users)
        .doc(uId)
        .collection(FirebaseStrings.cart)
        .get();
    response.docs.map((doc) {
      docsRefs.add(doc.reference);
    }).toList();
    return docsRefs;
  }

  @override
  Future<ReturnedIdsAndTheirCategory> getCategoryIds(
      DocumentReference categoryRef) async {
    List<String> ids = [];
    final response =
        await categoryRef.collection(FirebaseStrings.products).get();
    final category = categoryRef.id;
    response.docs.map((doc) => {ids.add(doc.id)}).toList();
    return ReturnedIdsAndTheirCategory(
      category: category,
      ids: ids,
    );
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getProduct(
      GetProductParams params) async {
    return await store
        .collection(FirebaseStrings.products)
        .doc(FirebaseStrings.categories)
        .collection(params.category)
        .doc(params.productId)
        .get();
  }

  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getProductsOfCategory(
      GetProductsOfOneCategoryParams params) async {
    List<DocumentSnapshot<Map<String, dynamic>>> productsDocs = [];
    for (String id in params.ids) {
      await getProduct(
              GetProductParams(category: params.category, productId: id))
          .then((productDoc) {
        productsDocs.add(productDoc);
      });
    }
    return productsDocs;
  }

  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getCartProducts(
      String uId) async {
    return await getCartCategories(uId).then((categoriesRefs) async {
      return await _getCartProducts(categoriesRefs).then((products) {
        return products;
      });
    });
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> _getCartProducts(
      List<DocumentReference> categoriesRefs) async {
    // < --------------------------------------------------------- >
    List<DocumentSnapshot<Map<String, dynamic>>> products = [];
    // < --------------------------------------------------------- >
    for (DocumentReference catRef in categoriesRefs) {
      await getCategoryIds(catRef).then((idsAndTheirCategory) async {
        await getProductsOfCategory(
          GetProductsOfOneCategoryParams(
            category: idsAndTheirCategory.category,
            ids: idsAndTheirCategory.ids,
          ),
        ).then((productsDocs) {
          products.addAll(productsDocs);
        });
      });
    }
    return products;
  }

  Future<void> _setCartCategoryToBeAvailableToFetch(
      AddToCartParams params) async {
    await store
        .collection(FirebaseStrings.users)
        .doc(params.uId)
        .collection(FirebaseStrings.cart)
        .doc(params.category)
        .set({"able_to_fetch": true});
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getCartProductsIdsOfCategory(
      DocumentReference reference) async {
    final response = await reference.collection(FirebaseStrings.products).get();
    if (response.docs.isEmpty) {
      /// Solving the second part of database problem :) .....
      /// Deleting categories that doesn't contain [products] :) .....
      await reference.delete();
    }
    return response;
  }
}

class GetProductsOfOneCategoryParams {
  final String category;
  final List<String> ids;

  GetProductsOfOneCategoryParams({
    required this.category,
    required this.ids,
  });
}

class GetProductParams {
  final String category;
  final String productId;

  GetProductParams({
    required this.category,
    required this.productId,
  });
}

class CartParams {
  final String uId;
  final String productId;
  final String category;

  CartParams({
    required this.uId,
    required this.category,
    required this.productId,
  });
}

class ReturnedIdsAndTheirCategory {
  final String category;
  final List<String> ids;

  ReturnedIdsAndTheirCategory({
    required this.category,
    required this.ids,
  });
}
