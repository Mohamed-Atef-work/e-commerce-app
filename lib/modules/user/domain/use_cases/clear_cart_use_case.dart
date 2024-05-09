import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/repository/cart_domain_repository.dart';

import 'delete_product_from_cart_use_case.dart';

class ClearCartUseCase extends BaseUseCase<void, ClearCartParams> {
  final CartDomainRepo repo;

  ClearCartUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(ClearCartParams params) async {
    return await repo.clearCart(params);
  }
}

class ClearCartParams {
  final List<DeleteFromCartParams> params;

  ClearCartParams({required this.params});
}
