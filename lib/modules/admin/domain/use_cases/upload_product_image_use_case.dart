import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class UploadProductImageUseCase extends BaseUseCase<Reference, File> {
  final AdminRepositoryDomain domain;

  UploadProductImageUseCase(this.domain);
  @override
  Future<Either<Failure, Reference>> call(File parameters) async {
    return await domain.uploadProductImage(parameters);
  }
}
