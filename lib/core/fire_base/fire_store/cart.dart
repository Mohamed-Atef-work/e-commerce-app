import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/user/data/data_source/cart_remote_data_source.dart';
import 'package:e_commerce_app/modules/user/domain/params/add_product_to_cart_params.dart';
import 'package:e_commerce_app/modules/user/domain/params/delete_product_from_cart_params.dart';

/*  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getCartProducts(
      String uId);*/

abstract class CartStore {
  Future<void> addToCart(AddToCartParams params);
  Future<void> deleteFromCart(DeleteFromCartParams params);
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getQuantities(
      GetQuantitiesParams params);
  Future<void> clearCart(List<DeleteFromCartParams> params);

  /// < ---------------------------------------------------------------------- >

  Future<ReturnedIdsAndTheirCategory> getCategoryIds(
      DocumentReference categoryRef);
  Future<List<DocumentReference>> getCartCategories(String uId);
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getProductsOfCategory(
      GetProductOfCategoryParams params);
}

class CartStoreImpl implements CartStore {
  final FirebaseFirestore _store;
  final StoreHelper _storeHelper;

  CartStoreImpl(this._store, this._storeHelper);
  @override
  Future<void> addToCart(AddToCartParams params) async {
    final exists = await _storeHelper.doesProductExists(
      GetProductParams(
        category: params.category,
        productId: params.productId,
      ),
    );

    if (exists) {
      await _store
          .collection(kUsers)
          .doc(params.uId)
          .collection(kCart)
          .doc(params.category)
          .collection(kProducts)
          .doc(params.productId)
          .set({
        kQuantity: params.quantity,
      });

      await _setCartCategoryToBeAvailableToFetch(params);
    } else {
      throw const ServerException(message: AppStrings.outOfStock);
    }
  }

  @override
  Future<void> deleteFromCart(DeleteFromCartParams params) async {
    await _store
        .collection(kUsers)
        .doc(params.uId)
        .collection(kCart)
        .doc(params.category)
        .collection(kProducts)
        .doc(params.productId)
        .delete();
  }

  @override
  Future<void> clearCart(List<DeleteFromCartParams> params) async {
    for (var param in params) {
      await deleteFromCart(param);
    }
  }

  @override
  Future<List<DocumentReference>> getCartCategories(String uId) async {
    List<DocumentReference> docsRefs = [];
    final response =
        await _store.collection(kUsers).doc(uId).collection(kCart).get();

    response.docs.map((doc) {
      docsRefs.add(doc.reference);
    }).toList();
    return docsRefs;
  }

  @override
  Future<ReturnedIdsAndTheirCategory> getCategoryIds(
      DocumentReference categoryRef) async {
    List<String> ids = [];
    final response = await categoryRef.collection(kProducts).get();
    final category = categoryRef.id;
    response.docs.map((doc) => {ids.add(doc.id)}).toList();
    return ReturnedIdsAndTheirCategory(category: category, ids: ids);
  }

  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getProductsOfCategory(
      GetProductOfCategoryParams params) async {
    List<DocumentSnapshot<Map<String, dynamic>>> productsDocs = [];

    for (String id in params.ids) {
      final productDoc = await _storeHelper.getProduct(
        GetProductParams(category: params.category, productId: id),
      );

      if (productDoc.exists) {
        productsDocs.add(productDoc);
      } else {
        await deleteFromCart(
          DeleteFromCartParams(
              uId: params.uId,
              productId: productDoc.id,
              category: params.category),
        );
      }

      print(productDoc.id);
      print(productDoc.exists);
    }
    return productsDocs;
  }

  Future<void> _setCartCategoryToBeAvailableToFetch(
      AddToCartParams params) async {
    await _store
        .collection(kUsers)
        .doc(params.uId)
        .collection(kCart)
        .doc(params.category)
        .set({"able_to_fetch": true});
  }

  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getQuantities(
      GetQuantitiesParams params) async {
    List<DocumentSnapshot<Map<String, dynamic>>> docs = [];
    for (GetQuantities product in params.productsParams) {
      final response = await _store
          .collection(kUsers)
          .doc(params.uId)
          .collection(kCart)
          .doc(product.category)
          .collection(kProducts)
          .doc(product.id)
          .get();
      docs.add(response);
    }

    return docs;
  }
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
    required this.ids,
    required this.category,
  });
}
/*  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getCartProducts(
      String uId) async {
    final referencesOfCategories = await getCartCategories(uId);
    final docsOfCartProducts =
        await _getCartProducts(referencesOfCategories, uId);

    return docsOfCartProducts;
  }*/
/*  Future<List<DocumentSnapshot<Map<String, dynamic>>>> _getCartProducts(
      List<DocumentReference> categoriesRefs, String uId) async {
    // < --------------------------------------------------------- >
    List<DocumentSnapshot<Map<String, dynamic>>> products = [];
    // < --------------------------------------------------------- >
    for (DocumentReference catRef in categoriesRefs) {
      final idsAndTheirCategory = await getCategoryIds(catRef);
      final docsOfCategoryProducts = await getProductsOfCategory(
          GetProductsOfOneCategoryParams(
            ids: idsAndTheirCategory.ids,
            category: idsAndTheirCategory.category,
          ),
          uId);
      products.addAll(docsOfCategoryProducts);
    }
    return products;
  }*/
