import 'package:dartz/dartz.dart';

import '../error/failure.dart';

/// put the Either.................
abstract class BaseUseCase<T, Parameters> {
  Future<Either<Failure, T>> call(Parameters parameters);
}

/// extends the Equatable..........
class NoParameters {
  const NoParameters();
}
