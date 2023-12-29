import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/services/fire_store_services/order.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';

class AddItemToOrderUseCase extends BaseUseCase<void, AddItemToOrderParams> {
  final OrderDomainRepo repo;

  AddItemToOrderUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(AddItemToOrderParams parameters) async {
    final result = await repo.addItemToOrder(parameters);
    return result;
  }
}
