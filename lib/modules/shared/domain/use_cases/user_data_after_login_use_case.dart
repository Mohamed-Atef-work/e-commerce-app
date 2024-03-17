import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/entities/shared_user_data_entity.dart';

class UserDataAfterLoginUseCase
    extends BaseUseCase<SharedUserDataEntity, AfterLoginParams> {
  final SharedDomainRepo _sharedRepo;
  final AuthRepositoryDomain _authRepo;

  UserDataAfterLoginUseCase(this._sharedRepo, this._authRepo);

  @override
  Future<Either<Failure, SharedUserDataEntity>> call(
      AfterLoginParams params) async {
    final getEither = await _authRepo.getUserData(params.uId);

    return getEither.fold(
      (getFailure) => Left(getFailure),
      (userEntity) async {
        final cachedUser = _cachedUser(userEntity, params);
        final saveEither = await _sharedRepo.saveUserDataLocally(cachedUser);
        return saveEither.fold(
          (saveFailure) => Left(saveFailure),
          (hasSaved) => Right(_shared(userEntity, params)),
        );
      },
    );
  }

  CachedUserDataModel _cachedUser(
    UserEntity userEntity,
    AfterLoginParams params,
  ) =>
      CachedUserDataModel(
        userEntity: userEntity,
        password: params.password,
        adminOrUser: params.adminUser,
      );

  SharedUserDataEntity _shared(
    UserEntity userEntity,
    AfterLoginParams params,
  ) =>
      SharedUserDataEntity(
        user: CachedUserDataModel(
          userEntity: userEntity,
          password: params.password,
          adminOrUser: params.adminUser,
        ),
        userCredential: params.userCredential,
      );
}

class AfterLoginParams {
  final String uId;
  final String password;
  final AdminUser adminUser;
  final UserCredential userCredential;

  AfterLoginParams({
    required this.uId,
    required this.password,
    required this.adminUser,
    required this.userCredential,
  });
}
