import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';

import '../../../../core/services/fire_store_services/cart.dart';

abstract class CartDomainRepo {
  Future<Either<Failure, void>> addToCart(CartParams params);
  Future<Either<Failure, void>> deleteFromCart(CartParams params);
  Future<Either<Failure, List<ProductEntity>>> getCartProducts(String uId);
  Future<Either<Failure, ProductEntity>> getProduct(GetProductParams params);
  Future<Either<Failure, List<ProductCategoryEntity>>> getCartCategories(
      String uId);
  Future<Either<Failure, List<ProductEntity>>> getProductsOfCategory(
      GetProductsOfOneCategoryParams params);
}
