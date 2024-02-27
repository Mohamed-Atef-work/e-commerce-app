import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_item_entity.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_product_quantities_of_cart_use_case.dart';

/*class GetCartProductsUseCase extends BaseUseCase<List<CartItemEntity>, String> {
  final CartDomainRepo repo;

  GetCartProductsUseCase(this.repo);
  @override
  Future<Either<Failure, List<CartItemEntity>>> call(String params) async {
    final productsEither = await repo.getCartProducts(params);
    return productsEither.fold(
      (productsFailure) => Left(productsFailure),
      (cartEntities) async {




        final quantitiesEither = await repo.getQuantities(quantitiesParams);
        return quantitiesEither
            .fold((quantitiesFailure) => Left(quantitiesFailure), (quantities) {

          return Right(cartItems);
        });
      },
    );
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
}*/
