import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

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

  const AddProductParams({required this.product});
}

class AddProductUseCaseNew extends BaseUseCase<void, AddProductParamsNew> {
  final AdminRepositoryDomain _adminRepo;
  final SharedDomainRepo _sharedRepo;

  AddProductUseCaseNew(this._adminRepo, this._sharedRepo);

  @override
  Future<Either<Failure, void>> call(AddProductParamsNew params) async {
    final pickEither = await _sharedRepo.pickGalleryImage();

    return pickEither.fold(
      (pickFailure) => Left(pickFailure),
      (imageFile) async => await _afterPickingImage(params, imageFile),
    );
  }

  _afterPickingImage(AddProductParamsNew params, File imageFile) async {
    final uploadEither = await _sharedRepo.uploadImage(imageFile);

    return uploadEither.fold(
      (uploadImageFailure) => Left(uploadImageFailure),
      (imageRef) async => await _afterUploadingImage(params, imageRef),
    );
  }

  _afterUploadingImage(AddProductParamsNew params, Reference imageRef) async {
    final downloadUrlEither = await _sharedRepo.downloadImageUrl(imageRef);
    return downloadUrlEither.fold(
      (urlFailure) => Left(urlFailure),
      (imageUrl) async => await _addProduct(params, imageUrl),
    );
  }

  _addProduct(AddProductParamsNew params, String imageUrl) async {
    final addParams = _addParams(params, imageUrl);

    return await _adminRepo.addProduct(AddProductParams(product: addParams));
  }

  _addParams(AddProductParamsNew params, String imageUrl) => ProductModel(
        description: params.description,
        category: params.category,
        location: params.location,
        price: params.price,
        name: params.name,
        image: imageUrl,
      );
}

class AddProductParamsNew {
  final String description;
  final String category;
  final String location;
  final String name;
  final File image;
  final num price;

  AddProductParamsNew({
    required this.description,
    required this.location,
    required this.category,
    required this.image,
    required this.price,
    required this.name,
  });
}
