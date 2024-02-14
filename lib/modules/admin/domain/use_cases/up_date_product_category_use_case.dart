import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateProductCategoryUseCase
    extends BaseUseCase<void, UpDateProductsCategoryparams> {
  final AdminRepositoryDomain domainRepo;

  UpdateProductCategoryUseCase(this.domainRepo);
  @override
  Future<Either<Failure, void>> call(
      UpDateProductsCategoryparams params) async {
    return domainRepo.upDateProductCategory(params);
  }
}

class UpDateProductsCategoryparams extends Equatable {
  final String name;
  final String id;

  const UpDateProductsCategoryparams({
    required this.name,
    required this.id,
  });
  Map<String, dynamic> toJson() => {
        "name": name,
      };

  @override
  List<Object?> get props => [
        name,
        id,
      ];
}
