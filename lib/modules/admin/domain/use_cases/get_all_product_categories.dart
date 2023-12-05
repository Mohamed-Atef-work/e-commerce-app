import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class GetAllProductCategoriesUseCase
    extends BaseUseCase<Stream<List<ProductCategoryEntity>>, NoParameters> {
  final AdminRepositoryDomain domainRepo;

  GetAllProductCategoriesUseCase(this.domainRepo);
  @override
  Future<Either<Failure, Stream<List<ProductCategoryEntity>>>> call(
      NoParameters parameters) async {
    return domainRepo.getAllProductCategories();
  }
}
