import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_params.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/shared_user_data_entity.dart';

class GetInitialDataUseCase
    extends BaseUseCase<SharedUserDataEntity, NoParams> {
  final SharedDomainRepo _sharedRepo;
  final AuthRepositoryDomain _authRepo;

  GetInitialDataUseCase(this._sharedRepo, this._authRepo);

  @override
  Future<Either<Failure, SharedUserDataEntity>> call(NoParams params) async {
    final userEither = await _sharedRepo.getUserDataLocally();

    return userEither.fold((userFailure) => Left(userFailure), (user) async {
      final loginParams = LoginParams(
        adminOrUser: user.adminOrUser,
        email: user.userEntity.email,
        password: user.password,
      );
      final loginEither = await _authRepo.signIn(loginParams);
      return loginEither.fold(
        (loginFailure) => Left(loginFailure),
        (userCredential) => Right(
          SharedUserDataEntity(userCredential: userCredential, user: user),
        ),
      );
    });
  }

  _login(CachedUserDataEntity user) async {
    final loginParams = LoginParams(
      adminOrUser: user.adminOrUser,
      email: user.userEntity.email,
      password: user.password,
    );
    final loginEither = await _authRepo.signIn(loginParams);
    return loginEither.fold(
      (loginFailure) => Left(loginFailure),
      (userCredential) => Right(
        SharedUserDataEntity(userCredential: userCredential, user: user),
      ),
    );
  }
}
