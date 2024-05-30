import 'dart:io';
import 'package:dartz/dartz.dart';

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/params/delete_product_params.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class UpdateProductWithNewImageUseCase
    extends BaseUseCase<String, UpdateProductWithNewImageParams> {
  final AddProductUseCase _addProductUseCase;
  final AdminRepositoryDomain _adminRepo;

  UpdateProductWithNewImageUseCase(this._adminRepo, this._addProductUseCase);

  @override
  Future<Either<Failure, String>> call(
      UpdateProductWithNewImageParams params) async {
    final deleteParams = _deleteParams(params);
    final addParams = _addParams(params);

    final deleteEither = await _adminRepo.deleteProduct(deleteParams);

    return deleteEither.fold(
      (uploadImageFailure) => Left(uploadImageFailure),
      (_) async => await _addProductUseCase(addParams),
    );
  }

  _deleteParams(UpdateProductWithNewImageParams params) =>
      DeleteProductParams(params.product.id!, params.product.category);

  _addParams(UpdateProductWithNewImageParams params) => AddProductParams(
        description: params.product.description,
        price: params.product.price,
        name: params.product.name,
        image: params.imageFile,
        category: params.newCat,
      );
}

class UpdateProductWithNewImageParams {
  final ProductModel product;
  final File imageFile;
  final String newCat;

  const UpdateProductWithNewImageParams({
    required this.imageFile,
    required this.product,
    required this.newCat,
  });
}
