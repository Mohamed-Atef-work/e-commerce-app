import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utils/fire_base_strings.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';

abstract class CartStore {
  Future<void> addToCart(AddToCartParams params);
  Future<void> deleteFromCart(DeleteFromCartParams params);
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getCartProducts(
      String uId);
  Future<void> clearCart(List<DeleteFromCartParams> params);

  /// < ---------------------------------------------------------------------- >
  Future<List<DocumentReference>> getCartCategories(String uId);
  Future<IdsAndTheirCategoryAndQuantities> getCategoryIds(
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
        .set({FirebaseStrings.quantity: params.quantity});
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
  Future<IdsAndTheirCategoryAndQuantities> getCategoryIds(
      DocumentReference categoryRef) async {
    List<String> ids = [];
    final response =
        await categoryRef.collection(FirebaseStrings.products).get();
    final category = categoryRef.id;
    response.docs.map((doc) => {ids.add(doc.id)}).toList();

    final List<IdAndQuantity> idsAndQuantities =
        await _getQuantityAndId(ids: ids, categoryRef: categoryRef);

    /// delete category if There ore No products;
    if (ids.isEmpty) {
      await categoryRef.delete();
    }

    return IdsAndTheirCategoryAndQuantities(
      idsAndQuantities: idsAndQuantities,
      category: category,
    );
  }

  Future<List<IdAndQuantity>> _getQuantityAndId({
    required List<String> ids,
    required DocumentReference categoryRef,
  }) async {
    List<IdAndQuantity> idAndQuantity = [];
    for (String id in ids) {
      final response =
          await categoryRef.collection(FirebaseStrings.products).doc(id).get();
      idAndQuantity.add(IdAndQuantity.fromJson(
        id: id,
        json: response.data()!,
      ));
    }

    return idAndQuantity;
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

  Future<List<DocAndQuantity>> _getCartProducts(
      List<DocumentReference> categoriesRefs) async {
    // < --------------------------------------------------------- >
    List<DocumentSnapshot<Map<String, dynamic>>> products = [];
    List<int> quantities = [];
    // < --------------------------------------------------------- >
    for (DocumentReference catRef in categoriesRefs) {
      await getCategoryIds(catRef).then((idsAndTheirCategoryAndQuantity) async {
        List<String> ids = List.generate(
            idsAndTheirCategoryAndQuantity.idsAndQuantities.length,
            (index) => idsAndTheirCategoryAndQuantity.idsAndQuantities[index].id);
        List<int> quantities = List.generate(
            idsAndTheirCategoryAndQuantity.idsAndQuantities.length,
                (index) => idsAndTheirCategoryAndQuantity.idsAndQuantities[index].quantity);

        await getProductsOfCategory(
          GetProductsOfOneCategoryParams(
            category: idsAndTheirCategoryAndQuantity.category,
            ids: ids,
          ),
        ).then((productsDocs) {
          products.addAll(productsDocs);
        });
      });
    }

    final List<DocAndQuantity> finalResult = List.generate(length, (index) => DocAndQuantity(quantity: ,doc: ));

    return finalResult;
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

  @override
  Future<void> clearCart(List<DeleteFromCartParams> params) async {
    for (var param in params) {
      await deleteFromCart(param);
    }
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

class IdsAndTheirCategoryAndQuantities {
  final String category;
  final List<IdAndQuantity> idsAndQuantities;

  IdsAndTheirCategoryAndQuantities({
    required this.category,
    required this.idsAndQuantities,
  });
}

class IdAndQuantity {
  final int quantity;
  final String id;

  IdAndQuantity({
    required this.quantity,
    required this.id,
  });

  factory IdAndQuantity.fromJson({
    required Map<String, dynamic> json,
    required String id,
  }) =>
      IdAndQuantity(
        quantity: json["quantity"],
        id: id,
      );
}

class DocAndQuantity {
  final DocumentSnapshot<Map<String, dynamic>> doc;
  final int quantity;

  DocAndQuantity({required this.doc, required this.quantity});
}
