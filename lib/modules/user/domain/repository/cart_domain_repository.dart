import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/user/domain/entities/cart_item_entity.dart';
import 'package:e_commerce_app/modules/user/domain/params/clear_cart_params.dart';
import 'package:e_commerce_app/modules/user/domain/params/add_product_to_cart_params.dart';
import 'package:e_commerce_app/modules/user/domain/params/delete_product_from_cart_params.dart';

abstract class CartDomainRepo {
  Future<Either<Failure, void>> addToCart(AddToCartParams params);
  Future<Either<Failure, void>> clearCart(ClearCartParams params);
  Future<Either<Failure, void>> deleteFromCart(DeleteFromCartParams params);
  Future<Either<Failure, List<CartItemEntity>>> getCartProducts(String uId);
}
