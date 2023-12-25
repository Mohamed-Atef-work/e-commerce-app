import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utils/fire_base_strings.dart';
import 'package:equatable/equatable.dart';

abstract class FavoriteStoreServices {
  Future<List<DocumentSnapshot<Map<String, dynamic>>>> getFavProductsOfCategory(
      {required List<String> productIds, required String category});
  Future<QuerySnapshot<Map<String, dynamic>>> getFavProductsIdsOfCategory(
      DocumentReference reference);
  Future<QuerySnapshot<Map<String, dynamic>>> getFavCategories(String uId);
  Future<void> addFav({
    required String category,
    required String uId,
    required String productId,
  });
  Future<void> deleteFav(FavoriteParameters parameters);
}

class FavoriteStoreServicesImpl implements FavoriteStoreServices {
  final FirebaseFirestore store;
  FavoriteStoreServicesImpl(this.store);

  @override

  Future<void> deleteFav(FavoriteParameters parameters) async {
    await store
        .collection(FirebaseStrings.users)
        .doc(parameters.uId)
        .collection(FirebaseStrings.favorites)
        .doc(parameters.category)
        .collection(FirebaseStrings.products)
        .doc(parameters.productId)
        .delete();
  }

  @override
  Future<void> addFav({
    required String category,
    required String uId,
    required String productId,
  }) async {
    await _setFavCategoryToBeAvailableToFetch(
      FavoriteParameters(
        uId: uId,
        productId: productId,
        category: category,
      ),
    ).then((value) async {
      await store
          .collection(FirebaseStrings.users)
          .doc(uId)
          .collection(FirebaseStrings.favorites)
          .doc(category)
          .collection(FirebaseStrings.products)
          .doc(productId)
          .set(const {});
    });
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getFavCategories(
      String uId) async {
    return await store
        .collection(FirebaseStrings.users)
        .doc(uId)
        .collection(FirebaseStrings.favorites)
        .get();
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getFavProductsIdsOfCategory(
      DocumentReference reference) async {
    return await reference.collection(FirebaseStrings.products).get();
  }

  @override
  Future<List<DocumentSnapshot<Map<String, dynamic>>>>
      getFavProductsOfCategory({
    required List<String> productIds,
    required String category,
  }) async {
    List<DocumentSnapshot<Map<String, dynamic>>> products = [];

    for (int index = 0; index < productIds.length; index++) {
      await _getFavProduct(category: category, productId: productIds[index])
          .then((product) {
        products.add(product);
      });
    }
    return products;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getFavProduct(
      {required String category, required String productId}) async {
    return await store
        .collection(FirebaseStrings.products)
        .doc(FirebaseStrings.categories)
        .collection(category)
        .doc(productId)
        .get();
  }

  Future<void> _setFavCategoryToBeAvailableToFetch(
      FavoriteParameters parameters) async {
    await store
        .collection(FirebaseStrings.users)
        .doc(parameters.uId)
        .collection(FirebaseStrings.favorites)
        .doc(parameters.category)
        .set({"able_to_fetch": true});
  }

  /// get Categories;
  // get Fav categories Items;
  /// LOOP
  // ----> {
  /// --------- > get Items of One category;
  // --------------- > get IDs of One category;
  /// ------------------ > LOOP
  /// ----------------------- > {
  // ---------------------------- > On get One Fav Item;
  /// ------------------------> {
  /// --- > }
}

/// ///////////////////////////////////////////////////////////
class FavoriteParameters extends Equatable {
  final String uId;
  final String productId;
  final String category;

  const FavoriteParameters({
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
