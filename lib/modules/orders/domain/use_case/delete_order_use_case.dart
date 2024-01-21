import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteOrderUseCase extends BaseUseCase<void, DeleteOrderParams> {
  final OrderDomainRepo repo;

  DeleteOrderUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(DeleteOrderParams parameters) async {
    final result = await repo.deleteOrder(parameters);
    return result;
  }
}

class DeleteOrderParams extends Equatable {
  //final List<String> orderItemsIds;
  final DocumentReference orderRef;
  final String uId;

  const DeleteOrderParams(
      {
      //required this.orderItemsIds,
      required this.orderRef,
      required this.uId});

  @override
  List<Object?> get props => [
        orderRef, //orderItemsIds
      ];
}
