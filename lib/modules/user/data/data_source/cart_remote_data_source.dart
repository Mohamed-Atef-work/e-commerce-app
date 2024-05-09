import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/cart.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/user/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/user/data/models/cart_category_model.dart';
import 'package:e_commerce_app/modules/user/domain/entities/cart_item_entity.dart';
import 'package:e_commerce_app/modules/user/domain/entities/cart_category_entity.dart';
import 'package:e_commerce_app/modules/user/domain/use_cases/clear_cart_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/use_cases/delete_product_from_cart_use_case.dart';

abstract class CartBaseRemoteDataSource {
  Future<void> addToCart(AddToCartParams params);
  Future<void> clearCart(ClearCartParams params);
  Future<void> deleteFromCart(DeleteFromCartParams params);
  Future<List<int>> getQuantities(GetQuantitiesParams params);
  Future<List<CartItemEntity>> getCartProducts(String uId);
  //Future<CartEntity> _getProductsOfCategory(CartCategoryEntity params);
  //Future<List<ProductEntity>> getProduct(GetProductParams params);
  //Future<List<CartCategoryEntity>> getCartCategories(String uId);
}

class CartRemoteDataSource implements CartBaseRemoteDataSource {
  final CartStore _cartStore;
  final StoreHelper _storeHelper;

  CartRemoteDataSource(this._cartStore, this._storeHelper);

  @override
  Future<void> addToCart(AddToCartParams params) async {
    try {
      await _cartStore.addToCart(params);
      print("<---------- Added ---------->");
    } on ServerException catch (_) {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteFromCart(DeleteFromCartParams params) {
    return _cartStore.deleteFromCart(params).then((value) {
      print("<---------- Deleted ---------->");
    }).catchError((error) {
      throw ServerException(message: error);
    });
  }

  @override
  Future<void> clearCart(ClearCartParams params) async {
    _cartStore.clearCart(params.params).catchError((error) {
      print(error.toString());
      throw ServerException(message: error);
    });
  }

  @override
  Future<List<int>> getQuantities(GetQuantitiesParams params) async {
    final quantitiesDocs = await _cartStore.getQuantities(params);
    final quantities =
        List<int>.of(quantitiesDocs.map((e) => e.data()![kQuantity]));
    return quantities;
  }

  Future<List<CartItemEntity>> _getQuantities(
      List<CartEntity> cartEntities, String uId) async {
    List<ProductEntity> products = [];
    for (CartEntity cart in cartEntities) {
      products.addAll(cart.products);
    }
    final getQuantitiesParams = List.generate(
      products.length,
      (index) => GetQuantities(
        id: products[index].id!,
        category: products[index].category,
      ),
    );
    final quantitiesParams =
        GetQuantitiesParams(productsParams: getQuantitiesParams, uId: uId);

    final quantities = await getQuantities(quantitiesParams);
    final cartItems = List.generate(
      quantities.length,
      (index) => CartItemEntity(
        quantity: quantities[index],
        product: products[index],
      ),
    );
    return cartItems;
  }

  @override
  Future<List<CartItemEntity>> getCartProducts(String uId) async {
    final categories = await _getCartCategories(uId).catchError((error) {
      print(error.toString());
      throw ServerException(message: error);
    });

    final cartEntities = await _getCart(categories, uId).catchError((error) {
      print(error.toString());
      throw ServerException(message: error);
    });

    final cart = await _getQuantities(cartEntities, uId).catchError((error) {
      print(error.toString());
      throw ServerException(message: error);
    });

    return cart;
  }

  Future<List<CartCategoryEntity>> _getCartCategories(String uId) async {
    final categoriesDocs = await _cartStore.getCartCategories(uId);
    final categories = List<CartCategoryEntity>.of(
      categoriesDocs
          .map((cateDoc) =>
              CartCategoryModel.fromJson(reference: cateDoc, id: cateDoc.id))
          .toList(),
    );

    print(
        "_________________Cart Categories Length________________${categories.length}");

    return categories;
  }

  /// Just Extra clean , I'm not sure if it's clean or not :)
  Future<List<CartEntity>> _getCart(
      List<CartCategoryEntity> categories, String uId) async {
    List<CartEntity> cartEntities = [];

    ///
    for (CartCategoryEntity category in categories) {
      /// There is a problem with the data base Which ........
      /// When all fav are deleted from a Category ...........
      /// It still can be accessed Which Creates an EMPTY model .......
      /// That make problems in the UI :) .......
      final cartEntity = await _getEntityOfOneCategory(category, uId);
      if (cartEntity.products.isNotEmpty) {
        cartEntities.add(cartEntity);
      }
    }
    return cartEntities;
  }

  Future<CartEntity> _getEntityOfOneCategory(
      CartCategoryEntity category, String uId) async {
    final ids = await _getIdsOfOneCategory(category.reference);
    final cartEntity = await _getEntityByIds(
        GetProductOfCategoryParams(category: category.id, ids: ids, uId: uId));
    return cartEntity;
  }

  Future<List<String>> _getIdsOfOneCategory(
      DocumentReference categoryRef) async {
    final idsDocs = await _storeHelper.getProductsIdsOfCategory(categoryRef);
    final ids = List<String>.of(idsDocs.docs.map((favDoc) => favDoc.id));
    return ids;
  }

  Future<CartEntity> _getEntityByIds(GetProductOfCategoryParams params) async {
    final productsDocs = await _cartStore.getProductsOfCategory(params);
    final products = List<ProductEntity>.of(
      productsDocs.map(
          (doc) => ProductModel.formJson(json: doc.data()!, productId: doc.id)),
    );
    final cartEntity =
        CartEntity(category: params.category, products: products);
    return cartEntity;
  }
}

class GetQuantitiesParams {
  final List<GetQuantities> productsParams;
  final String uId;

  GetQuantitiesParams({
    required this.productsParams,
    required this.uId,
  });
}

class GetQuantities {
  final String category;
  final String id;

  GetQuantities({
    required this.id,
    required this.category,
  });
}
