import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

class UpdateUserDataUseCase extends BaseUseCase<bool, CachedUserDataEntity> {
  final SharedDomainRepo _sharedRepo;
  final AuthRepositoryDomain _authRepo;

  UpdateUserDataUseCase(this._sharedRepo, this._authRepo);

  @override
  Future<Either<Failure, bool>> call(CachedUserDataEntity params) async {
    final remoteEither = await _authRepo.storeUserData(params.userEntity);

    return remoteEither.fold(
      (remoteFailure) => Left(remoteFailure),
      (r) async => await _sharedRepo.saveUserDataLocally(params),
    );
  }
}
