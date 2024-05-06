import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic object;

  const Failure({
    this.object,
    required this.message,
  });
  @override
  List<Object?> get props => [
        message,
        object,
      ];
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.object,
    required super.message,
  });
}

class LocalDataBaseFailure extends Failure {
  const LocalDataBaseFailure({
    required super.message,
  });
}
