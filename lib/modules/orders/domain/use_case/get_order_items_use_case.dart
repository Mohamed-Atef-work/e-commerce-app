import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:equatable/equatable.dart';

class GetOrderItemsUseCase extends BaseUseCase<void, GetOrderItemsParams> {
  final OrderDomainRepo repo;

  GetOrderItemsUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(GetOrderItemsParams parameters) async {
    final result = repo.getOrderItems(parameters);
    return result;
  }

}

class GetOrderItemsParams extends Equatable {
  final DocumentReference orderRef;

  const GetOrderItemsParams({required this.orderRef});

  @override
  List<Object> get props => [orderRef];
}
