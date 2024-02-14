import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';

class AddItemToOrderUseCase extends BaseUseCase<void, AddItemToOrderParams> {
  final OrderDomainRepo repo;

  AddItemToOrderUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(AddItemToOrderParams params) async {
    final result = await repo.addItemToOrder(params);
    return result;
  }
}

class AddItemToOrderParams {
  final DocumentReference orderRef;
  final OrderItemModel item;

  AddItemToOrderParams({
    required this.orderRef,
    required this.item,
  });
}
