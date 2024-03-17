import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class LogoutUseCase extends BaseUseCase<bool, NoParams> {
  final SharedDomainRepo _sharedRepo;
  final AuthRepositoryDomain _authRepo;

  LogoutUseCase(this._sharedRepo, this._authRepo);
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    final deleteEither = await _sharedRepo.deleteUserDataLocally();
    return deleteEither.fold(
      (deleteFailure) => Left(deleteFailure),
      (deleteResult) async {
        final logOutEither = await _authRepo.logOut();
        return logOutEither.fold(
          (logOutFailure) => Left(logOutFailure),
          (r) => Right(deleteResult),
        );
      },
    );
  }
}
