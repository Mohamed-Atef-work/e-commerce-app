import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class LogOurUseCase extends BaseUseCase<bool, Noparams> {
  final SharedDomainRepo _sharedRepo;
  final AuthRepositoryDomain _authRepo;

  LogOurUseCase(this._sharedRepo, this._authRepo);
  @override
  Future<Either<Failure, bool>> call(Noparams params) async {
    final logOutEither = await _authRepo.logOut();
    final deleteEither = await _sharedRepo.deleteUserDataLocally();
    return logOutEither.fold(
      (logOutFailure) => Left(logOutFailure),
      (r) => deleteEither.fold(
        (deleteFailure) => Left(deleteFailure),
        (r) => Right(r),
      ),
    );
  }
}
