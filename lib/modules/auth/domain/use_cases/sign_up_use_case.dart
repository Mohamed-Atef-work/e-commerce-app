import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/auth/domain/repository/auth_domain_repository.dart';

import '../../../../core/use_case/base_use_case.dart';

class SignUpUseCase extends BaseUseCase<UserCredential, SignUpParameters> {
  final AuthRepositoryDomain domainRepository;

  SignUpUseCase(this.domainRepository);

  @override
  Future<Either<Failure, UserCredential>> call(
      SignUpParameters parameters) async {
    print(
        "<--------------------- In The SIGN_UP Use Case ------------------------>");
    final result = await domainRepository.signUp(parameters);
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

class SignUpParameters {
  final String name, email, password;

  SignUpParameters({
    required this.name,
    required this.email,
    required this.password,
  });
}
