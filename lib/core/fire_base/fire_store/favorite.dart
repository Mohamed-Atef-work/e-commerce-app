import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';

abstract class FavoriteStore {
  Future<QuerySnapshot<Map<String, dynamic>>> getProductsIdsOfCategory(
      DocumentReference reference);
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getProductsOfCategory(
      {required List<String> ids,
      required String category,
      required String uId});

  Future<QuerySnapshot<Map<String, dynamic>>> getCategories(String uId);
  Future<void> deleteFav(AddDeleteFavoriteParams params);
  Future<void> addFav(AddDeleteFavoriteParams params);
}

class FavoriteStoreImpl implements FavoriteStore {
  final FirebaseFirestore store;
  FavoriteStoreImpl(this.store);

  @override
  Future<void> deleteFav(AddDeleteFavoriteParams params) async {
    await store
        .collection(kUsers)
        .doc(params.uId)
        .collection(kFavorites)
        .doc(params.category)
        .collection(kProducts)
        .doc(params.productId)
        .delete();
  }

  @override
  Future<void> addFav(AddDeleteFavoriteParams params) async {
    final response = await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(params.category)
        .doc(params.productId)
        .get();

    if (response.exists) {
      await _setFavCategoryToBeAvailableToFetch(
        Favoriteparams(
          uId: params.uId,
          category: params.category,
          productId: params.productId,
        ),
      );
      await store
          .collection(kUsers)
          .doc(params.uId)
          .collection(kFavorites)
          .doc(params.category)
          .collection(kProducts)
          .doc(params.productId)
          .set(const {});
    }
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getCategories(String uId) async {
    return await store
        .collection(kUsers)
        .doc(uId)
        .collection(kFavorites)
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getProductsIdsOfCategory(
      DocumentReference reference) async {
    final response = await reference.collection(kProducts).get();
    if (response.docs.isEmpty) {
      /// Solving the second part of database problem :) .....
      /// Deleting categories that doesn't contain [Fvs] :) .....
      await reference.delete();
    }
    return response;
  }

  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getProductsOfCategory({
    required List<String> ids,
    required String category,
    required String uId,
  }) async {
    List<DocumentSnapshot<Map<String, dynamic>>> products = [];

    for (String id in ids) {
      final productDoc = await _getProduct(category: category, productId: id);

      if (productDoc.exists) {
        products.add(productDoc);
      } else {
        await deleteFav(
          AddDeleteFavoriteParams(
              uId: uId, productId: productDoc.id, category: category),
        );
      }
    }
    return products;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getProduct(
      {required String category, required String productId}) async {
    final response = await store
        .collection(kProducts)
        .doc(kCategories)
        .collection(category)
        .doc(productId)
        .get();

    print(response.id);
    print(response.exists);

    return response;
  }

  Future<void> _setFavCategoryToBeAvailableToFetch(
      Favoriteparams params) async {
    await store
        .collection(kUsers)
        .doc(params.uId)
        .collection(kFavorites)
        .doc(params.category)
        .set({"able_to_fetch": true});
  }

  /// get Categories;
  // get Fav categories Items;
  /// LOOP
  // -----> {
  /// --------- > get Items of One category;
  // ----------------> get IDs of One category;
  /// ------------------ > LOOP
  /// ------------------------> {
  // ---------------------------- > On get One Fav Item;
  /// ------------------------> {
  // ---------------->
  // -----> }
}

/// ///////////////////////////////////////////////////////////
class Favoriteparams extends Equatable {
  final String uId;
  final String productId;
  final String category;

  const Favoriteparams({
    required this.uId,
    required this.productId,
    required this.category,
  });

  @override
  List<Object?> get props => [
        uId,
        productId,
        category,
      ];
}
