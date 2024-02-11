import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/init_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class InitUseCase extends BaseUseCase<InitEntity, NoParameters> {
  final SharedDomainRepo _sharedRepo;
  final AuthRepositoryDomain _authRepo;

  InitUseCase(this._sharedRepo, this._authRepo);

  @override
  Future<Either<Failure, InitEntity>> call(NoParameters parameters) async {
    final userEither = await _sharedRepo.getUserDataLocally();
    final userAdminEither = await _sharedRepo.getUserOrAdminLocally();
    final passwordEither = await _sharedRepo.getUserPasswordLocally();

    return userEither.fold(
      (userFailure) => Left(userFailure),
      (user) => passwordEither.fold(
        (passwordFailure) => Left(passwordFailure),
        (password) => userAdminEither.fold(
            (userAdminEitherFailure) => Left(userAdminEitherFailure),
            (adminUser) async => await _login(user, password, adminUser)),
      ),
    );
  }

  _login(UserEntity user, String password, AdminUser adminUser) async {
    final loginParams = LoginParameters(email: user.email, password: password);
    final loginEither = await _authRepo.signIn(loginParams);
    return loginEither.fold(
      (loginFailure) => Left(loginFailure),
      (userCredential) => Right(
        InitEntity(
          userCredential: userCredential,
          userEntity: user,
          adminUser: adminUser,
        ),
      ),
    );
  }
}
