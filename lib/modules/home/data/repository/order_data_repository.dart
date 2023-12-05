import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/services/fire_store_services/order.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/home/data/data_source/order_remote_data_source.dart';
import 'package:e_commerce_app/modules/home/domain/entities/order_data_entity.dart';
import 'package:e_commerce_app/modules/home/domain/repository/order_domain_repository.dart';

class OrderDataRepo implements OrderDomainRepo {
  final OrderBaseRemoteDataSource dataSource;

  OrderDataRepo(this.dataSource);

  @override
  Future<Either<Failure, void>> addItemToOrder(
      AddItemToOrderParams params) async {
    try {
      final result = await dataSource.addItemToOrder(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> addOrder(AddOrderParams params) async {
    try {
      final result = await dataSource.addOrder(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteItemFromOrder(
      DeleteItemFromOrderParams params) async {
    try {
      final result = await dataSource.deleteItemFromOrder(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteOrder(
      DocumentReference<Object?> orderRef) async {
    try {
      final result = await dataSource.deleteOrder(orderRef);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, OrderDataEntity>> getOrderData(
      DocumentReference<Object?> orderRef) async {
    try {
      final result = await dataSource.getOrderData(orderRef);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getOrderItems(
      DocumentReference<Object?> orderRef) async {
    try {
      final result = await dataSource.getOrderItems(orderRef);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderDataEntity>>> getUserOrders(
      String userId) async {
    try {
      final result = await dataSource.getUserOrders(userId);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, Stream<List<OrderDataEntity>>>> streamOfUserOrders(
      String userId) async {
    try {
      final result = await dataSource.streamOfUserOrders(userId);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, Stream<List<UserEntity>>>> streamUsersWhoOrdered() async {
    try {
      final result = await dataSource.streamUsersWhoOrdered();
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderData(
      UpDateOrderDataParams params) async {
    try {
      final result = await dataSource.updateOrderData(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }
}
