import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

/*class UpdateNameUseCase extends BaseUseCase<bool, UpdateAddressParams> {
  final SharedDomainRepo _sharedRepo;
  final AuthRepositoryDomain _authRepo;

  UpdateNameUseCase(this._sharedRepo, this._authRepo);

  @override
  Future<Either<Failure, bool>> call(UpdateAddressParams params) async {
    final user = UserEntity(
      name: params.name,
      id: params.cachedUser.userEntity.id,
      phone: params.cachedUser.userEntity.phone,
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

class UpdateAddressParams {
  final String name;
  final CachedUserDataEntity cachedUser;

  UpdateAddressParams({
    required this.name,
    required this.cachedUser,
  });
}*/
