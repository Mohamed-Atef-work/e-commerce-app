import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';

class GetCartProductsQuantitiesUseCase
    extends BaseUseCase<List<int>, GetQuantitiesParams> {
  final CartDomainRepo repo;

  GetCartProductsQuantitiesUseCase(this.repo);
  @override
  Future<Either<Failure, List<int>>> call(
      GetQuantitiesParams parameters) async {
    return repo.getQuantities(parameters);
  }
}

class GetQuantities {
  final String id;
  final String category;

  GetQuantities({required this.id, required this.category});
}

class GetQuantitiesParams {
  final String uId;
  final List<GetQuantities> productsParams;

  GetQuantitiesParams({
    required this.uId,
    required this.productsParams,
  });
}
