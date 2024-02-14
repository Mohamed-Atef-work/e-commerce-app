import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class AddProductUseCase extends BaseUseCase<void, AddProductparams> {
  final AdminRepositoryDomain domainRepository;

  AddProductUseCase(
    this.domainRepository,
  );

  @override
  Future<Either<Failure, void>> call(AddProductparams params) async {
    return await domainRepository.addProduct(params);
  }
}

class AddProductparams {
  final ProductModel product;

  const AddProductparams({
    required this.product,
  });
}
