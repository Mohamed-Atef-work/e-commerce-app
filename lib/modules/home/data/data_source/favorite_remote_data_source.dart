import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/services/fire_store_services/favorite.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/data/models/favorite_category_model.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_category_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';

abstract class FavoriteBaseRemoteDataSource {
  Future<List<FavoriteEntity>> getFavorites(String uId);
  Future<List<FavoriteCategoryEntity>> getFavCategories(String uId);
  Future<FavoriteEntity> getFavOfOneCategory(FavoriteCategoryEntity category);
  Future<void> addFav(AddDeleteFavoriteParams params);
  Future<void> deleteFav(AddDeleteFavoriteParams params);
}

class FavoriteRemoteDataSource implements FavoriteBaseRemoteDataSource {
  final FavoriteStore favoriteStore;

  FavoriteRemoteDataSource(this.favoriteStore);

  @override
  Future<void> addFav(AddDeleteFavoriteParams params) async {
    await favoriteStore.addFav(params).then((value) {
      print("<---------- Added ---------->");
    }).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<List<FavoriteCategoryEntity>> getFavCategories(String uId) async {
    return await favoriteStore.getFavCategories(uId).then(

        ///
        (categories) {
      return List<FavoriteCategoryEntity>.of(
        categories.docs
            .map(
              (cateDoc) => FavoriteCategoryModel.fromJson(
                  id: cateDoc.id, reference: cateDoc.reference),
            )
            .toList(),
      );

      ///
    }).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<FavoriteEntity> getFavOfOneCategory(
      FavoriteCategoryEntity category) async {
    return await _getIdsOfOneCategory(category.reference).then((ids) async {
      return await _getProductsOfOneCategory(
        category: category.id,
        productsIds: ids,
      ).then((fav) {
        return fav;
      });
    });
  }

  @override
  Future<List<FavoriteEntity>> getFavorites(String uId) async {
    return await getFavCategories(uId).then((categories) async {
      ///
      return await _getFavorites(categories).then((favorites) {
        return favorites;
      });

      ///
    });
  }

  /// Just Extra clean , I'm not sure if it's clean or not :)
  Future<List<FavoriteEntity>> _getFavorites(
      List<FavoriteCategoryEntity> category) async {
    List<FavoriteEntity> favorites = [];

    ///
    for (int i = 0; i < category.length; i++) {
      /// There is a problem with the data base Which ........
      /// When all fav are deleted from a Category ...........
      /// It still can be accessed Which Creates an EMPTY model .......
      /// That make problems in the UI :) .......
      await getFavOfOneCategory(category[i]).then((favoriteEntity) {
        if (favoriteEntity.products.isNotEmpty) {
          favorites.add(favoriteEntity);
        }
      });

      ///
      /*await _getIdsOfOneCategory(category[i].reference).then((ids) async {
        await _getProductsOfOneCategory(
          category: category[i].id,
          productsIds: ids,
        ).then((fav) {
          favorites.add(fav);
        });
      });*/
    }
    return favorites;
  }

  Future<List<String>> _getIdsOfOneCategory(
      DocumentReference categoryRef) async {
    return await favoriteStore
        .getFavProductsIdsOfCategory(categoryRef)
        .then((favorites) {
      return List<String>.of(favorites.docs.map((favDoc) => favDoc.id));
    }).catchError((error) {
      throw ServerException(message: error);
    });
  }

  Future<FavoriteEntity> _getProductsOfOneCategory({
    required String category,
    required List<String> productsIds,
  }) async {
    return await favoriteStore
        .getFavProductsOfCategory(
      productIds: productsIds,
      category: category,
    )
        .then((products) {
      return FavoriteEntity(
        category: category,
        products: List<ProductEntity>.of(
          products
              .map(
                (doc) => ProductModel.formJson(
                  json: doc.data()!,
                  productId: doc.id,
                ),
              )
              .toList(),
        ),
      );
    }).catchError((error) {
      throw ServerException(message: error);
    });
  }

  @override
  Future<void> deleteFav(AddDeleteFavoriteParams params) {
    return favoriteStore.deleteFav(params).then((value) {
      print("<---------- Deleted ---------->");
    }).catchError((error) {
      throw ServerException(message: error);
    });
  }
}

/*.catchError((error) {
throw ServerException(message: error);
})*/
