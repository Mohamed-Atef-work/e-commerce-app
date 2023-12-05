import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class AddNewProductCategoryUseCase
    extends BaseUseCase<void, AddNewProductsCategoryParameters> {
  final AdminRepositoryDomain domainRepository;

  AddNewProductCategoryUseCase(this.domainRepository);
  @override
  Future<Either<Failure, void>> call(
      AddNewProductsCategoryParameters parameters) async {
    return await domainRepository.addNewProductCategory(parameters);
  }
}

class AddNewProductsCategoryParameters {
  final String name;

  AddNewProductsCategoryParameters({
    required this.name,
  });
  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
