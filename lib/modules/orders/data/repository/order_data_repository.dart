import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/data/data_source/order_remote_data_source.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:e_commerce_app/modules/orders/domain/params/add_item_to_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_item_from_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/get_order_data_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/get_order_items_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/up_date_order_data_params.dart';

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
      return Left(
        ServerFailure(
          object: exception.object,
          message: exception.message,
        ),
      );
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
  Future<Either<Failure, void>> deleteOrder(DeleteOrderParams params) async {
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
  Future<Either<Failure, List<OrderItemEntity>>> getOrderItems(
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
  Either<Failure, Stream<List<OrderDataEntity>>> streamOfUserOrders(
      String userId) {
    try {
      final result = dataSource.streamOfUserOrders(userId);
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

  @override
  Either<Failure, Stream<List<UserEntity>>> streamUsersWhoOrdered() {
    try {
      final result = dataSource.streamUsersWhoOrdered();
      return Right(result);
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.message));
    }
  }
}
