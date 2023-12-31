import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';

class AddToCartUseCase extends BaseUseCase<void, AddToCartParams> {
  final CartDomainRepo repo;

  AddToCartUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(AddToCartParams parameters) async {
    return await repo.addToCart(parameters);
  }
}

class AddToCartParams extends Equatable {
  final String category;
  final String productId;
  final String uId;

  const AddToCartParams({
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
