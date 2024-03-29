import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_item_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/clear_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/not_needed/get_product_quantities_of_cart_use_case.dart';

abstract class CartDomainRepo {
  Future<Either<Failure, void>> addToCart(AddToCartParams params);
  Future<Either<Failure, void>> clearCart(ClearCartParams params);
  Future<Either<Failure, void>> deleteFromCart(DeleteFromCartParams params);
  Future<Either<Failure, List<CartItemEntity>>> getCartProducts(String uId);

  //Future<Either<Failure, List<ProductWithQuantityEntity>>> getCart(GetCartParams params);
/*  Future<Either<Failure, ProductEntity>> getProduct(
      GetCartProductsParams params);*/
  /* Future<Either<Failure, List<ProductEntity>>> getProductsOfCategory(
      GetProductsOfOneCategoryParams params);*/
}
