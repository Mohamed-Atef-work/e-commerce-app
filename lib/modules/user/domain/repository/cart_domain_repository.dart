import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/user/domain/entities/cart_item_entity.dart';
import 'package:e_commerce_app/modules/user/domain/use_cases/clear_cart_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/use_cases/delete_product_from_cart_use_case.dart';

abstract class CartDomainRepo {
  Future<Either<Failure, void>> addToCart(AddToCartParams params);
  Future<Either<Failure, void>> clearCart(ClearCartParams params);
  Future<Either<Failure, void>> deleteFromCart(DeleteFromCartParams params);
  Future<Either<Failure, List<CartItemEntity>>> getCartProducts(String uId);
}
