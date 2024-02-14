import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:equatable/equatable.dart';

class GetOrderDataUseCase extends BaseUseCase<OrderDataEntity, GetOrderDataParams> {
  final OrderDomainRepo repo;

  GetOrderDataUseCase(this.repo);
  @override
  Future<Either<Failure, OrderDataEntity>> call(GetOrderDataParams params) async {
    final result = await repo.getOrderData(params);
    return result;
  }
}

class GetOrderDataParams extends Equatable {
  final DocumentReference orderRef;

  const GetOrderDataParams({required this.orderRef});

  @override
  List<Object?> get props => [orderRef];
}
