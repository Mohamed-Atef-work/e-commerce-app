import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';

class DownloadProductImageUrlUseCase extends BaseUseCase<String, Reference> {
  final SharedDomainRepo domain;

  DownloadProductImageUrlUseCase(this.domain);
  @override
  Future<Either<Failure, String>> call(Reference params) async {
    return await domain.downloadImageUrl(params);
  }
}
