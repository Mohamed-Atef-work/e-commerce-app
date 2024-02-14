import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';

class DeleteFromCartUseCase extends BaseUseCase<void, DeleteFromCartParams> {
  final CartDomainRepo repo;

  DeleteFromCartUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(DeleteFromCartParams params) async {
    return await repo.deleteFromCart(params);
  }
}

class DeleteFromCartParams extends Equatable {
  final String category;
  final String productId;
  final String uId;

  const DeleteFromCartParams({
    required this.category,
    required this.productId,
    required this.uId,
  });

  @override
  List<Object?> get props => [
        uId,
        category,
        productId,
      ];
}
