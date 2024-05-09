import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/modules/user/domain/entities/cart_item_entity.dart';
import 'package:e_commerce_app/modules/user/domain/use_cases/clear_cart_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/repository/cart_domain_repository.dart';
import 'package:e_commerce_app/modules/user/data/data_source/cart_remote_data_source.dart';
import 'package:e_commerce_app/modules/user/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/use_cases/delete_product_from_cart_use_case.dart';

class CartDataRepo implements CartDomainRepo {
  final CartBaseRemoteDataSource dataSource;

  CartDataRepo(this.dataSource);

  @override
  Future<Either<Failure, void>> addToCart(AddToCartParams params) async {
    try {
      final result = await dataSource.addToCart(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFromCart(
      DeleteFromCartParams params) async {
    try {
      final result = await dataSource.deleteFromCart(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCartProducts(
      String params) async {
    try {
      final result = await dataSource.getCartProducts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart(ClearCartParams params) async {
    try {
      final result = await dataSource.clearCart(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }
}
