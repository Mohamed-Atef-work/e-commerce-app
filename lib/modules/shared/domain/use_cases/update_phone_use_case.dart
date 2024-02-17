import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

class UpdateNameUseCase extends BaseUseCase<bool, UpdateNameParams> {
  final SharedDomainRepo _sharedRepo;
  final AuthRepositoryDomain _authRepo;

  UpdateNameUseCase(this._sharedRepo, this._authRepo);

  @override
  Future<Either<Failure, bool>> call(UpdateNameParams params) async {
    final user = UserEntity(
      phone: params.phone,
      id: params.cachedUser.userEntity.id,
      name: params.cachedUser.userEntity.name,
      email: params.cachedUser.userEntity.email,
      address: params.cachedUser.userEntity.address,
    );
    final cachedUser = CachedUserDataModel(
      adminOrUser: params.cachedUser.adminOrUser,
      password: params.cachedUser.password,
      userEntity: user,
    );

    final remoteEither = await _authRepo.storeUserData(user);

    return remoteEither.fold(
      (remoteFailure) => Left(remoteFailure),
      (r) async => await _sharedRepo.saveUserDataLocally(cachedUser),
    );
  }
}

class UpdateNameParams {
  final String phone;
  final CachedUserDataEntity cachedUser;

  UpdateNameParams({
    required this.phone,
    required this.cachedUser,
  });
}
