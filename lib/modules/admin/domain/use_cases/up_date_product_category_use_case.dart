import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:equatable/equatable.dart';

class UpdateProductCategoryUseCase
    extends BaseUseCase<void, UpDateProductsCategoryParameters> {
  final AdminRepositoryDomain domainRepo;

  UpdateProductCategoryUseCase(this.domainRepo);
  @override
  Future<Either<Failure, void>> call(
      UpDateProductsCategoryParameters parameters) async {
    return domainRepo.upDateProductCategory(parameters);
  }
}

class UpDateProductsCategoryParameters extends Equatable {
  final String name;
  final String id;

  const UpDateProductsCategoryParameters({
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
