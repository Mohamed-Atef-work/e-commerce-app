import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class GetAllProductCategoriesUseCase
    extends BaseStreamUseCase<Stream<List<ProductCategoryEntity>>, NoParams> {
  final AdminRepositoryDomain domainRepo;

  GetAllProductCategoriesUseCase(this.domainRepo);
  @override
  Either<Failure, Stream<List<ProductCategoryEntity>>> call(
      NoParams params)  {
    return domainRepo.getAllProductCategories();
  }
}
