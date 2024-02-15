import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/auth/domain/use_cases/get_user_data_use_case.dart';
import 'package:e_commerce_app/modules/shared/data/models/cached_user_data_model.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/failure.dart';

import '../../../../core/use_case/base_use_case.dart';
import '../repository/auth_domain_repository.dart';

class LoginInUseCase extends BaseUseCase<UserCredential, LoginParams> {
  final AuthRepositoryDomain _authRepo;

  LoginInUseCase(this._authRepo);
  @override
  Future<Either<Failure, UserCredential>> call(LoginParams params) async =>
      await _authRepo.signIn(params);
}

class LoginParams extends Equatable {
  final String email, password;
  final AdminUser adminOrUser;
  const LoginParams({
    required this.adminOrUser,
    required this.password,
    required this.email,
  });
  @override
  List<Object?> get props => [
        email,
        password,
        adminOrUser,
      ];
}
/*    print(
        "<----------------- fold -- Error ----------------------> ${l.message}");
    print(
        "<----------------- fold -- Success ------------------->${r.user!.uid}");*/
