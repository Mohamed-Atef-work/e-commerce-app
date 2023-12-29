import 'package:dartz/dartz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/services/fire_store_services/order.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/delete_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_data_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/get_order_items_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/up_date_order_data_use_case.dart';

abstract class OrderDomainRepo {
  Future<Either<Failure, void>> deleteItemFromOrder(
      DeleteItemFromOrderParams params);
  Future<Either<Failure, void>> deleteOrder(DeleteOrderParams params);
  Future<Either<Failure, void>> addItemToOrder(AddItemToOrderParams params);
  Future<Either<Failure, void>> updateOrderData(UpDateOrderDataParams params);
  Future<Either<Failure, void>> addOrder(AddOrderParams params);
  Future<Either<Failure, OrderDataEntity>> getOrderData(
      GetOrderDataParams parameters);
  Future<Either<Failure, List<ProductEntity>>> getOrderItems(
      GetOrderItemsParams params);
  Future<Either<Failure, Stream<List<UserEntity>>>> streamUsersWhoOrdered();
  Future<Either<Failure, Stream<List<OrderDataEntity>>>> streamOfUserOrders(
      String userId);
  Future<Either<Failure, List<OrderDataEntity>>> getUserOrders(String userId);
}
