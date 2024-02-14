import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

import '../../../../core/use_case/base_use_case.dart';

class SignUpUseCase extends BaseUseCase<UserCredential, SignUpparams> {
  final AuthRepositoryDomain domainRepository;

  SignUpUseCase(this.domainRepository);

  @override
  Future<Either<Failure, UserCredential>> call(
      SignUpparams params) async {
    print(
        "<--------------------- In The SIGN_UP Use Case ------------------------>");
    final result = await domainRepository.signUp(params);
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

class SignUpparams {
  final String name, email, password;

  SignUpparams({
    required this.name,
    required this.email,
    required this.password,
  });
}
