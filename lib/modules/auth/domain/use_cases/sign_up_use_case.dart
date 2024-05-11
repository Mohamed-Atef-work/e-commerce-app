import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/auth/data/model/user_model.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

class SignUpUseCase extends BaseUseCase<void, SignUpParams> {
  final AuthRepositoryDomain _autRepo;

  SignUpUseCase(this._autRepo);

  @override
  Future<Either<Failure, void>> call(SignUpParams params) async {
    final signUpEither = await _autRepo.signUp(params);
    return signUpEither.fold(
      (signUpFailure) => Left(signUpFailure),
      (userCredential) async => await _autRepo.storeUserData(
        _user(params, userCredential),
      ),
    );
  }

  _user(SignUpParams params, UserCredential userCredential) => UserModel(
        name: params.name,
        email: params.email,
        id: userCredential.user!.uid,
      );
}

class SignUpParams {
  final String name, email, password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}
