import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class UpdateProductWithOutNewImageUseCase
    extends BaseUseCase<String, UpdateProductParams> {
  final AdminRepositoryDomain _adminRepo;

  UpdateProductWithOutNewImageUseCase(this._adminRepo);

  @override
  Future<Either<Failure, String>> call(UpdateProductParams params) async {
    final deleteParams = _deleteParams(params);
    final addParams = _addParams(params);

    final deleteEither = await _adminRepo.deleteProduct(deleteParams);

    return deleteEither.fold(
      (deleteFailure) => Left(deleteFailure),
      (_) async => await _adminRepo.addProduct(addParams),
    );
  }

  _deleteParams(UpdateProductParams params) =>
      DeleteProductParams(params.product.id!, params.product.category);

  _addParams(UpdateProductParams params) => ProductModelParams(
        product: ProductModel(
          description: params.product.description,
          image: params.product.image,
          price: params.product.price,
          name: params.product.name,
          category: params.newCat,
        ),
      );
}

class UpdateProductParams {
  final String newCat;
  final ProductModel product;

  const UpdateProductParams({
    required this.newCat,
    required this.product,
  });
}
