import 'package:dartz/dartz.dart';
import '../error/failure.dart';

/// put the Either.................
abstract class BaseUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class BaseStreamUseCase<T, Params> {
  Either<Failure, T> call(Params params);
}

/// extends the Equatable..........
class NoParams {
  const NoParams();
}
