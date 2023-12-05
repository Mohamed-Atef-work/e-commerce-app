import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';

class DownloadProductImageUrlUseCase extends BaseUseCase<String,Reference>{
  final AdminRepositoryDomain domain;

  DownloadProductImageUrlUseCase(this.domain);
  @override
  Future<Either<Failure, String>> call(Reference parameters) async{
    return await domain.downloadProductImageUrl(parameters);


  }
}