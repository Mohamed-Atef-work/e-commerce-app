import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';

class SaveInitialDataUseCase extends BaseUseCase<bool, CachedUserDataModel> {
  final SharedDomainRepo _sharedRepo;

  SaveInitialDataUseCase(this._sharedRepo);

  @override
  Future<Either<Failure, bool>> call(CachedUserDataModel params) async =>
      await _sharedRepo.saveUserDataLocally(params);
}
