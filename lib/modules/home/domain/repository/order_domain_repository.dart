import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/order_data_entity.dart';

import '../../../../core/services/fire_store_services/order.dart';

abstract class OrderDomainRepo {
  Future<Either<Failure, void>> deleteItemFromOrder(
      DeleteItemFromOrderParams params);
  Future<Either<Failure, void>> deleteOrder(DocumentReference orderRef);
  Future<Either<Failure, void>> addItemToOrder(AddItemToOrderParams params);
  Future<Either<Failure, void>> updateOrderData(UpDateOrderDataParams params);
  Future<Either<Failure, void>> addOrder(AddOrderParams params);
  Future<Either<Failure, OrderDataEntity>> getOrderData(
      DocumentReference orderRef);
  Future<Either<Failure, List<ProductEntity>>> getOrderItems(
      DocumentReference orderRef);
  Future<Either<Failure, Stream<List<UserEntity>>>> streamUsersWhoOrdered();
  Future<Either<Failure, Stream<List<OrderDataEntity>>>> streamOfUserOrders(
      String userId);
  Future<Either<Failure, List<OrderDataEntity>>> getUserOrders(String userId);
}
