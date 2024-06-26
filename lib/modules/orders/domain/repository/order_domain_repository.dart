import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/params/add_item_to_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_item_from_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/delete_order_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/get_order_data_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/get_order_items_params.dart';
import 'package:e_commerce_app/modules/orders/domain/params/up_date_order_data_params.dart';

abstract class OrderDomainRepo {
  Future<Either<Failure, void>> deleteItemFromOrder(
      DeleteItemFromOrderParams params);
  Future<Either<Failure, void>> addOrder(AddOrderParams params);
  Future<Either<Failure, void>> deleteOrder(DeleteOrderParams params);
  Future<Either<Failure, void>> addItemToOrder(AddItemToOrderParams params);
  Future<Either<Failure, void>> updateOrderData(UpDateOrderDataParams params);
  Future<Either<Failure, List<OrderDataEntity>>> getUserOrders(String userId);
  Future<Either<Failure, OrderDataEntity>> getOrderData(
      GetOrderDataParams params);
  Future<Either<Failure, List<OrderItemEntity>>> getOrderItems(
      GetOrderItemsParams params);
  Either<Failure, Stream<List<UserEntity>>> streamUsersWhoOrdered();
  Either<Failure, Stream<List<OrderDataEntity>>> streamOfUserOrders(
      String userId);
}
