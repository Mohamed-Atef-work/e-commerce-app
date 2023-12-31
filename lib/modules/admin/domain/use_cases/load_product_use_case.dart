import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:equatable/equatable.dart';

import '../entities/product_entity.dart';

class LoadProductsUseCase
    extends BaseUseCase<Stream<List<ProductEntity>>, LoadProductsParameters> {
  final AdminRepositoryDomain domain;

  LoadProductsUseCase(this.domain);
  @override
  Future<Either<Failure, Stream<List<ProductEntity>>>> call(
      LoadProductsParameters parameters) async {
    return await domain.loadProducts(parameters);
  }
}

class LoadProductsParameters extends Equatable {
  final String category;

  const LoadProductsParameters({
    required this.category,
  });

  @override
  List<Object?> get props => [
        category,
      ];
}
