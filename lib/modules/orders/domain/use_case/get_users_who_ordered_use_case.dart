import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';


class GetUsersWhoOrderedUseCase
    extends BaseUseCase<Stream<List<UserEntity>>, NoParameters> {
  final OrderDomainRepo orderRepo;

  GetUsersWhoOrderedUseCase(this.orderRepo);
  @override
  Future<Either<Failure, Stream<List<UserEntity>>>> call(
      NoParameters parameters) async {
    return await orderRepo.streamUsersWhoOrdered();
  }
}
