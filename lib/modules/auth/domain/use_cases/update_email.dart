import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class UpdateEmailUseCase extends BaseUseCase<void, UpdateEmailParams> {
  final AuthRepositoryDomain repo;

  UpdateEmailUseCase(this.repo);

  @override
  Future<Either<Failure, void>> call(UpdateEmailParams parameters) async {
    return await repo.updateEmail(parameters);
  }
}

class UpdateEmailParams {
  final String password;
  final String email;

  UpdateEmailParams({required this.password, required this.email});
}
