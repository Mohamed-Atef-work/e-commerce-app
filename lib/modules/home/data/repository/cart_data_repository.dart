import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/services/fire_store_services/cart.dart';
import 'package:e_commerce_app/modules/home/data/data_source/cart_remote_data_source.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_cart_products_use_case.dart';

class CartDataRepo implements CartDomainRepo {
  final CartBaseRemoteDataSource dataSource;

  CartDataRepo(this.dataSource);

  @override
  Future<Either<Failure, void>> addToCart(AddToCartParams parameters) async {
    try {
      final result = await dataSource.addToCart(parameters);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFromCart(
      DeleteFromCartParams parameters) async {
    try {
      final result = await dataSource.deleteFromCart(parameters);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, List<CartEntity>>> getCartProducts(
      GetCartProductsParams params) async {
    try {
      final result = await dataSource.getCartProducts(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }
}
