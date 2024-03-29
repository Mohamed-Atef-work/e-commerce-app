import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class DeleteProductUseCase extends BaseUseCase<void, DeleteProductParams> {
  final AdminRepositoryDomain domain;

  DeleteProductUseCase(this.domain);
  @override
  Future<Either<Failure, void>> call(DeleteProductParams params) async {
    return await domain.deleteProduct(params);
  }
}

class DeleteProductParams extends Equatable {
  final String productId;
  final String category;

  const DeleteProductParams(this.productId, this.category);

  @override
  List<Object?> get props => [
        productId,
        category,
      ];
}
