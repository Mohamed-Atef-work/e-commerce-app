import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/init_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

class GetInitialDataUseCase extends BaseUseCase<InitEntity, NoParameters> {
  final SharedDomainRepo _sharedRepo;
  final AuthRepositoryDomain _authRepo;

  GetInitialDataUseCase(this._sharedRepo, this._authRepo);

  @override
  Future<Either<Failure, InitEntity>> call(NoParameters params) async {
    final userEither = await _sharedRepo.getUserDataLocally();

    return userEither.fold(
      (userFailure) => Left(userFailure),
      (user) async {
        final loginParams = LoginParameters(
            email: user.userEntity.email, password: user.password);
        final loginEither = await _authRepo.signIn(loginParams);
        return loginEither.fold(
          (loginFailure) => Left(loginFailure),
          (userCredential) => Right(
            InitEntity(user: user, userCredential: userCredential),
          ),
        );
      },
    );
  }

  _login(CachedUserDataEntity user) async {
    final loginParams =
        LoginParameters(email: user.userEntity.email, password: user.password);
    final loginEither = await _authRepo.signIn(loginParams);
    return loginEither.fold(
      (loginFailure) => Left(loginFailure),
      (userCredential) => Right(
        InitEntity(user: user, userCredential: userCredential),
      ),
    );
  }
}
