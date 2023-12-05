import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/failure.dart';

import '../../../../core/use_case/base_use_case.dart';
import '../repository/auth_domain_repository.dart';

class LoginInUseCase extends BaseUseCase<UserCredential, LoginParameters> {
  final AuthRepositoryDomain domain;

  LoginInUseCase(this.domain);
  @override
  Future<Either<Failure, UserCredential>> call(
      LoginParameters parameters) async {
    print(
        "<--------------------- In The SignIN Use Case ------------------------>");
    final result = await domain.signIn(parameters);
    result.fold((l) {
      print(
          "<----------------- fold -- Error ----------------------> ${l.message}");
    }, (r) {
      print(
          "<----------------- fold -- Success ------------------->${r.user!.uid}");
    });
    return result;
  }
}

class LoginParameters extends Equatable {
  final String email, password;
  const LoginParameters({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [
        email,
        password,
      ];
}
