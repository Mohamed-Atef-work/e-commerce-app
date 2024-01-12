import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/services/fire_store_services/cart.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/data/models/cart_category_model.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_category_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/clear_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_cart_products_use_case.dart';

abstract class CartBaseRemoteDataSource {
  Future<void> addToCart(AddToCartParams params);
  Future<void> deleteFromCart(DeleteFromCartParams params);
  Future<CartEntity> getProductsOfCategory(CartCategoryEntity params);
  Future<List<CartEntity>> getCartProducts(GetCartProductsParams params);
  Future<void> clearCart(ClearCartParams params);

  //Future<List<ProductEntity>> getProduct(GetProductParams params);
  //Future<List<CartCategoryEntity>> getCartCategories(String uId);
}

class CartRemoteDataSource implements CartBaseRemoteDataSource {
  final CartStore cartStore;

  CartRemoteDataSource(this.cartStore);

  @override
  Future<void> addToCart(AddToCartParams params) async {
    await cartStore.addToCart(params).then((value) {
      print("<---------- Added ---------->");
    }).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> deleteFromCart(DeleteFromCartParams params) {
    return cartStore.deleteFromCart(params).then((value) {
      print("<---------- Deleted ---------->");
    }).catchError((error) {
      throw ServerException(message: error);
    });
  }

  Future<List<CartCategoryEntity>> _getCartCategories(String uId) async {
    return await cartStore.getCartCategories(uId).then((categories) {
      return List<CartCategoryEntity>.of(
        categories
            .map(
              (cateDoc) => CartCategoryModel.fromJson(
                reference: cateDoc,
                id: cateDoc.id,
              ),
            )
            .toList(),
      );
    }).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<CartEntity> getProductsOfCategory(CartCategoryEntity category) async {
    return await _getIdsOfOneCategory(category.reference).then((ids) async {
      return await _getProductsOfOneCategory(
              GetProductsOfOneCategoryParams(category: category.id, ids: ids))
          .then((fav) {
        return fav;
      });
    });
  }

  @override
  Future<List<CartEntity>> getCartProducts(GetCartProductsParams params) async {
    return await _getCartCategories(params.uId).then((categories) async {
      ///
      return await _getCarts(categories).then((favorites) {
        return favorites;
      });

      ///
    });
  }

  /// Just Extra clean , I'm not sure if it's clean or not :)
  Future<List<CartEntity>> _getCarts(List<CartCategoryEntity> category) async {
    List<CartEntity> favorites = [];

    ///
    for (int i = 0; i < category.length; i++) {
      /// There is a problem with the data base Which ........
      /// When all fav are deleted from a Category ...........
      /// It still can be accessed Which Creates an EMPTY model .......
      /// That make problems in the UI :) .......
      await getProductsOfCategory(category[i]).then((favoriteEntity) {
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
    return await cartStore
        .getCartProductsIdsOfCategory(categoryRef)
        .then((favorites) {
      return List<String>.of(favorites.docs.map((favDoc) => favDoc.id));
    }).catchError((error) {
      throw ServerException(message: error);
    });
  }

  Future<CartEntity> _getProductsOfOneCategory(
      GetProductsOfOneCategoryParams params) async {
    return await cartStore.getProductsOfCategory(params).then((products) {
      return CartEntity(
        category: params.category,
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
      print(error.toString());
      throw ServerException(message: error);
    });
  }

  @override
  Future<void> clearCart(ClearCartParams params) async {
    await cartStore.clearCart(params.params).catchError((error) {
      print(error.toString());
      throw ServerException(message: error);
    });
  }
}
