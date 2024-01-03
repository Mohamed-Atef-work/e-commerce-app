import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';

class DeleteItemFromOrderUseCase
    extends BaseUseCase<void, DeleteItemFromOrderParams> {
  final OrderDomainRepo repo;

  DeleteItemFromOrderUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(
      DeleteItemFromOrderParams parameters) async {
    final result = await repo.deleteItemFromOrder(parameters);
    return result;
  }
}

class DeleteItemFromOrderParams {
  final DocumentReference itemRef;

  DeleteItemFromOrderParams({
    required this.itemRef,
  });
}
