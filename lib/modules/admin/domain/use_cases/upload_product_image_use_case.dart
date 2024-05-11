import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';

class UploadProductImageUseCase extends BaseUseCase<Reference, File> {
  final SharedDomainRepo domain;

  UploadProductImageUseCase(this.domain);
  @override
  Future<Either<Failure, Reference>> call(File params) async {
    return await domain.uploadImage(params);
  }
}
