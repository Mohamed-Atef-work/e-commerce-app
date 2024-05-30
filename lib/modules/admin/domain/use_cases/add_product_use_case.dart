import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class AddProductUseCase extends BaseUseCase<String, AddProductParams> {
  final AdminRepositoryDomain _adminRepo;
  final SharedDomainRepo _sharedRepo;

  AddProductUseCase(this._adminRepo, this._sharedRepo);

  @override
  Future<Either<Failure, String>> call(AddProductParams params) async {
    final uploadEither = await _sharedRepo.uploadImage(params.image);

    return uploadEither.fold(
      (uploadImageFailure) => Left(uploadImageFailure),
      (imageRef) async => await _afterUploadingImage(params, imageRef),
    );
  }

  _afterUploadingImage(AddProductParams params, Reference imageRef) async {
    final downloadUrlEither = await _sharedRepo.downloadImageUrl(imageRef);
    return downloadUrlEither.fold(
      (urlFailure) => Left(urlFailure),
      (imageUrl) async => await _addProduct(params, imageUrl),
    );
  }

  _addProduct(AddProductParams params, String imageUrl) async {
    final addParams = _addParams(params, imageUrl);

    return await _adminRepo.addProduct(addParams);
  }

  ProductModelParams _addParams(params, String imageUrl) => ProductModelParams(
        product: ProductModel(
          description: params.description,
          category: params.category,
          price: params.price,
          name: params.name,
          image: imageUrl,
        ),
      );
}

class AddProductParams {
  final String description;
  final String category;
  final String name;
  final File image;
  final num price;

  AddProductParams({
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    required this.name,
  });
}

class ProductModelParams {
  final ProductModel product;

  const ProductModelParams({required this.product});
}
