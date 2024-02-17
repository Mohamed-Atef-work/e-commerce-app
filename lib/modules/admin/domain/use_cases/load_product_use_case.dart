import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:equatable/equatable.dart';

class LoadProductsUseCase
    extends BaseUseCase<Stream<List<ProductEntity>>, LoadProductsParams> {
  final AdminRepositoryDomain domain;

  LoadProductsUseCase(this.domain);
  @override
  Future<Either<Failure, Stream<List<ProductEntity>>>> call(
      LoadProductsParams params) async {
    return await domain.loadProducts(params);
  }
}

class LoadProductsParams extends Equatable {
  final String category;

  const LoadProductsParams({
    required this.category,
  });

  @override
  List<Object?> get props => [
        category,
      ];
}
