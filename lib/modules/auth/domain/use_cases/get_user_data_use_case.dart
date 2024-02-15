import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class GetUserDataUseCase extends BaseUseCase<UserEntity, String> {
  final AuthRepositoryDomain authRepo;

  GetUserDataUseCase(this.authRepo);
  @override
  Future<Either<Failure, UserEntity>> call(String params) async =>
      await authRepo.getUserData(params);
}

class GetUserDataParams {
  final String uId;

  GetUserDataParams({required this.uId});
}
