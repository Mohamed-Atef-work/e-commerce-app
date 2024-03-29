import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/favorite.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/data/models/favorite_category_model.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_favorite_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/entities/favorite_category_entity.dart';

abstract class FavoriteBaseRemoteDataSource {
  Future<void> addFav(AddDeleteFavoriteParams params);
  Future<List<FavoriteEntity>> getFavorites(String uId);
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
  Future<void> deleteFav(AddDeleteFavoriteParams params) {
    return favoriteStore.deleteFav(params).then((value) {
      print("<---------- Deleted ---------->");
    }).catchError((error) {
      throw ServerException(message: error);
    });
  }

  @override
  Future<List<FavoriteEntity>> getFavorites(String uId) async {
    final categories = await _getCategories(uId).catchError((error) {
      print(error.toString());
      throw ServerException(message: error.toString());
    });
    final favoriteEntities =
        await _getFavorites(categories, uId).catchError((error) {
      print(error.toString());
      throw ServerException(message: error.toString());
    });
    return favoriteEntities;
  }

  Future<List<FavoriteCategoryEntity>> _getCategories(String uId) async {
    final categoriesDocs = await favoriteStore.getCategories(uId);
    final categories = List<FavoriteCategoryEntity>.of(
      categoriesDocs.docs.map(
        (cateDoc) => FavoriteCategoryModel.fromJson(
            reference: cateDoc.reference, id: cateDoc.id),
      ),
    );

    return categories;
  }

  /// Just Extra clean , I'm not sure if it's clean or not :)
  Future<List<FavoriteEntity>> _getFavorites(
      List<FavoriteCategoryEntity> categories, String uId) async {
    List<FavoriteEntity> favorites = [];

    ///
    for (FavoriteCategoryEntity category in categories) {
      /// There is a problem with the dataBase Which ........
      /// When all fvs are deleted from a Category ...........
      /// It still can be accessed Which Creates an EMPTY model .......
      /// That make problems in the UI :) .......
      final favoriteEntity = await _getEntityOfOneCategory(category, uId);
      if (favoriteEntity.products.isNotEmpty) {
        favorites.add(favoriteEntity);
      }
    }
    return favorites;
  }

  Future<FavoriteEntity> _getEntityOfOneCategory(
      FavoriteCategoryEntity category, String uId) async {
    final ids = await _getIdsOfOneCategory(category.reference);
    final favoriteEntity =
        await _getEntityByIds(category: category.id, ids: ids, uId: uId);
    return favoriteEntity;
  }

  Future<List<String>> _getIdsOfOneCategory(
      DocumentReference categoryRef) async {
    final productsIdsDocs =
        await favoriteStore.getProductsIdsOfCategory(categoryRef);
    final productsIds =
        List<String>.of(productsIdsDocs.docs.map((favDoc) => favDoc.id));

    return productsIds;
  }

  Future<FavoriteEntity> _getEntityByIds({
    required List<String> ids,
    required String category,
    required String uId,
  }) async {
    final productsDocs = await favoriteStore.getProductsOfCategory(
        ids: ids, category: category, uId: uId);
    final products = List<ProductEntity>.of(
      productsDocs.map(
          (doc) => ProductModel.formJson(json: doc.data()!, productId: doc.id)),
    );

    final favoriteEntity =
        FavoriteEntity(category: category, products: products);

    return favoriteEntity;
  }
}

/*.catchError((error) {
throw ServerException(message: error);
})*/
