import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';

import '../../../../core/services/fire_store_services/cart.dart';

abstract class CartBaseRemoteDataSource {
  Future<void> addToCart(CartParams params);
  Future<void> deleteFromCart(CartParams params);
  Future<List<ProductEntity>> getCartProducts(String uId);
  Future<List<ProductEntity>> getProduct(GetProductParams params);
  Future<List<ProductCategoryEntity>> getCartCategories(String uId);
  Future<List<ProductEntity>> getProductsOfCategory(
      GetProductsOfOneCategoryParams params);
}

class CartRemoteDataSource implements CartBaseRemoteDataSource {
  final CartStoreServices cartStore;

  CartRemoteDataSource(this.cartStore);

  @override
  Future<void> addToCart(CartParams params) async {
    // TODO: implement addToCart
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFromCart(CartParams params) async {
    // TODO: implement deleteFromCart
    throw UnimplementedError();
  }

  @override
  Future<List<ProductCategoryEntity>> getCartCategories(String uId) async {
    // TODO: implement getCartCategories
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> getCartProducts(String uId) async {
    // TODO: implement getCartProducts
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> getProduct(GetProductParams params) async {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  Future<List<ProductEntity>> getProductsOfCategory(
      GetProductsOfOneCategoryParams params) async {
    // TODO: implement getProductsOfCategory
    throw UnimplementedError();
  }
}
