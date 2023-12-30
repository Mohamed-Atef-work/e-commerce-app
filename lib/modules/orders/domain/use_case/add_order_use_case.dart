import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';

class AddOrderUseCase extends BaseUseCase<void, AddOrderParams> {
  final OrderDomainRepo repo;

  AddOrderUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(AddOrderParams parameters) async {
    final result = await repo.addOrder(parameters);
    return result;
  }
}

class AddOrderParams {
  final List<OrderItemModel> items;
  final OrderDataModel orderData;
  final String uId;

  AddOrderParams({
    required this.items,
    required this.orderData,
    required this.uId,
  });
}
