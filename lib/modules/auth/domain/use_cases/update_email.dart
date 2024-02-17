import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class UpdateEmailUseCase extends BaseUseCase<bool, UpdateEmailParams> {
  final AuthRepositoryDomain _authRepo;
  final SharedDomainRepo _sharedRepo;

  UpdateEmailUseCase(this._authRepo, this._sharedRepo);

  @override
  Future<Either<Failure, bool>> call(UpdateEmailParams params) async {
    final emailEither = await _authRepo.updateEmail(params);
    final cachedData = CachedUserDataModel(
      userEntity: UserEntity(
        email: params.newEmail,
        id: params.cachedUserData.userEntity.id,
        name: params.cachedUserData.userEntity.name,
        phone: params.cachedUserData.userEntity.phone,
        address: params.cachedUserData.userEntity.address,
      ),
      password: params.cachedUserData.password,
      adminOrUser: params.cachedUserData.adminOrUser,
    );
    return emailEither.fold(
      (emailFailure) => Left(emailFailure),
      (r) async => await _sharedRepo.saveUserDataLocally(cachedData),
    );
  }
}

class UpdateEmailParams {
  final String newEmail;
  final CachedUserDataEntity cachedUserData;

  UpdateEmailParams({
    required this.newEmail,
    required this.cachedUserData,
  });
}
