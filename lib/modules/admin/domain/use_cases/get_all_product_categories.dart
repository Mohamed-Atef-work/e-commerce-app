import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class GetAllProductCategoriesUseCase
    extends BaseUseCase<Stream<List<ProductCategoryEntity>>, Noparams> {
  final AdminRepositoryDomain domainRepo;

  GetAllProductCategoriesUseCase(this.domainRepo);
  @override
  Future<Either<Failure, Stream<List<ProductCategoryEntity>>>> call(
      Noparams params) async {
    return domainRepo.getAllProductCategories();
  }
}
