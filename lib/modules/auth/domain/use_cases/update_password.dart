import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class UpdatePasswordUseCase extends BaseUseCase<void, UpdatePasswordParams> {
  final AuthRepositoryDomain repo;

  UpdatePasswordUseCase(this.repo);

  @override
  Future<Either<Failure, void>> call(UpdatePasswordParams params) async {
    return await repo.updatePassword(params);
  }
}

class UpdatePasswordParams {
  final String currentPassword;
  final String newPassword;

  UpdatePasswordParams(
      {required this.currentPassword, required this.newPassword});
}
