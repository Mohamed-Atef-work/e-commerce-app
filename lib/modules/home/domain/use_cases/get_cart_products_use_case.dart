import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';

class GetCartProductsUseCase extends BaseUseCase<void, GetCartProductsParams> {
  final CartDomainRepo repo;

  GetCartProductsUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(GetCartProductsParams parameters) async {
    return await repo.getCartProducts(parameters);
  }
}

class GetCartProductsParams extends Equatable {
  final String uId;

  const GetCartProductsParams({
    required this.uId,
  });

  @override
  List<Object?> get props => [
        uId,
      ];
}
