import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/store_user_data_use_case.dart';

class UpdateProfileUseCase extends BaseUseCase<void, UserModel> {
  final AuthRepositoryDomain repo;

  UpdateProfileUseCase(this.repo);
  @override
  Future<Either<Failure, void>> call(UserModel params) async {
    return await repo.storeUserData(params);
  }
}
