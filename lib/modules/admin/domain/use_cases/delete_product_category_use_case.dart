import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:equatable/equatable.dart';

class DeleteProductsCategoryUseCase
    extends BaseUseCase<void, DeleteProductsCategoryparams> {
  final AdminRepositoryDomain domainRepo;

  DeleteProductsCategoryUseCase(this.domainRepo);
  @override
  Future<Either<Failure, void>> call(
      DeleteProductsCategoryparams params) async {
    return domainRepo.deleteProductCategory(params);
  }
}

class DeleteProductsCategoryparams extends Equatable {
  final String id;
  final String name;

  const DeleteProductsCategoryparams(
      {required this.name, required this.id});

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
