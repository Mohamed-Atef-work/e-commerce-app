import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/cached_user_data_entity.dart';

class UpdateAddressUseCase extends BaseUseCase<bool, CachedUserDataEntity> {
  final SharedDomainRepo _sharedRepo;
  final AuthRepositoryDomain _authRepo;

  UpdateAddressUseCase(this._sharedRepo, this._authRepo);

  @override
  Future<Either<Failure, bool>> call(CachedUserDataEntity params) async {
    final user = _user(params);
    final remoteEither = await _authRepo.storeUserData(user);

    final cached = _cached(params, user);
    return remoteEither.fold(
      (remoteFailure) => Left(remoteFailure),
      (r) async => await _sharedRepo.saveUserDataLocally(cached),
    );
  }

  _cached(CachedUserDataEntity params, UserEntity user) => CachedUserDataModel(
        adminOrUser: params.adminOrUser,
        password: params.password,
        userEntity: user,
      );

  _user(CachedUserDataEntity params) => UserEntity(
        id: params.userEntity.id,
        name: params.userEntity.name,
        phone: params.userEntity.phone,
        email: params.userEntity.email,
        address: params.userEntity.address,
      );
}

/*class UpdateAddressParams {
  final String address;
  final CachedUserDataEntity cachedUser;

  UpdateAddressParams({
    required this.address,
    required this.cachedUser,
  });
}*/
