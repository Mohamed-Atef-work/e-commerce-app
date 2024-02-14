import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';

class AddToCartUseCase extends BaseUseCase<void, AddToCartParams> {
  final CartDomainRepo repo;

  AddToCartUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(AddToCartParams params) async {
    return await repo.addToCart(params);
  }
}

class AddToCartParams extends Equatable {
  final String uId;
  final int quantity;
  final String category;
  final String productId;

  const AddToCartParams({
    required this.uId,
    required this.quantity,
    required this.category,
    required this.productId,
  });

  @override
  List<Object?> get props => [
        uId,
        quantity,
        category,
        productId,
      ];
}
