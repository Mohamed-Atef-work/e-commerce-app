import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';

class AddProductUseCase extends BaseUseCase<void, AddProductParams> {
  final AdminRepositoryDomain domainRepository;

  AddProductUseCase(this.domainRepository);

  @override
  Future<Either<Failure, void>> call(AddProductParams params) async {
    return await domainRepository.addProduct(params);
  }
}

class AddProductParams {
  final ProductModel product;

  const AddProductParams({
    required this.product,
  });
}

class AddProductUseCaseNew extends BaseUseCase<void, AddProductParams> {
  final AdminRepositoryDomain _domainRepository;
  final SharedDomainRepo _sharedDomainRepo;

  AddProductUseCaseNew(this._domainRepository, this._sharedDomainRepo);

  @override
  Future<Either<Failure, void>> call(AddProductParams params) async {
    return await _domainRepository.addProduct(params);
  }
}
