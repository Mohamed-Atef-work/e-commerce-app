import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/favorite.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/user/domain/entities/favorite_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/user/data/models/favorite_category_model.dart';
import 'package:e_commerce_app/modules/user/domain/params/add_favorite_params.dart';
import 'package:e_commerce_app/modules/user/domain/entities/favorite_category_entity.dart';

abstract class FavoriteBaseRemoteDataSource {
  Future<void> addFav(AddDeleteFavoriteParams params);
  Future<List<FavoriteEntity>> getFavorites(String uId);
  Future<void> deleteFav(AddDeleteFavoriteParams params);
}

class FavoriteRemoteDataSource implements FavoriteBaseRemoteDataSource {
  final FavoriteStore _favoriteStore;
  final StoreHelper _storeHelper;

  FavoriteRemoteDataSource(this._favoriteStore, this._storeHelper);

  @override
  Future<void> addFav(AddDeleteFavoriteParams params) async {
    try {
      await _favoriteStore.addFav(params);
      print("<---------- Added ---------->");
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteFav(AddDeleteFavoriteParams params) {
    return _favoriteStore.deleteFav(params).then((value) {
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
    final categoriesDocs = await _favoriteStore.getCategories(uId);
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
        await _storeHelper.getProductsIdsOfCategory(categoryRef);
    final productsIds =
        List<String>.of(productsIdsDocs.docs.map((favDoc) => favDoc.id));

    return productsIds;
  }

  Future<FavoriteEntity> _getEntityByIds({
    required List<String> ids,
    required String category,
    required String uId,
  }) async {
    final productsDocs = await _favoriteStore.getProductsOfCategory(
      GetProductOfCategoryParams(
        category: category,
        ids: ids,
        uId: uId,
      ),
    );
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
