import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

class UpdateEmailUseCase extends BaseUseCase<bool, CachedUserDataEntity> {
  final AuthRepositoryDomain _authRepo;
  final SharedDomainRepo _sharedRepo;

  UpdateEmailUseCase(this._authRepo, this._sharedRepo);

  @override
  Future<Either<Failure, bool>> call(CachedUserDataEntity params) async {
    final updateEmail = UpdateEmailParams(
        password: params.password, newEmail: params.userEntity.email);
    final emailEither = await _authRepo.updateEmail(updateEmail);
    final remoteEither = await _authRepo.storeUserData(params.userEntity);

    return emailEither.fold(
      (emailFailure) => Left(emailFailure),
      (r) => remoteEither.fold((storeRemoteFailure) => Left(storeRemoteFailure),
          (r) async => await _sharedRepo.saveUserDataLocally(params)),
    );
  }
}

class UpdateEmailParams {
  final String password;
  final String newEmail;

  UpdateEmailParams({
    required this.password,
    required this.newEmail,
  });
}
