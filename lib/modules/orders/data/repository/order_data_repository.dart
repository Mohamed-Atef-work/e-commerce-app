import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/services/fire_store_services/order.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/data/data_source/order_remote_data_source.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_data_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_items_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/up_date_order_data_use_case.dart';

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
      DeleteOrderParams params) async {
    try {
      final result = await dataSource.deleteOrder(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, OrderDataEntity>> getOrderData(
      GetOrderDataParams params) async {
    try {
      final result = await dataSource.getOrderData(params);
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getOrderItems(
      GetOrderItemsParams params) async {
    try {
      final result = await dataSource.getOrderItems(params);
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
  Future<Either<Failure, Stream<List<UserEntity>>>>
      streamUsersWhoOrdered() async {
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
