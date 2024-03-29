import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/order_data_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';

class GetUserOrdersUseCase
    extends BaseStreamUseCase<Stream<List<OrderDataEntity>>, String> {
  final OrderDomainRepo repo;

  GetUserOrdersUseCase(this.repo);
  @override
  Either<Failure, Stream<List<OrderDataEntity>>> call(String params) {
    final result = repo.streamOfUserOrders(params);
    return result;
  }
}
