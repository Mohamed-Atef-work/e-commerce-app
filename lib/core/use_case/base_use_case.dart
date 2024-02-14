import 'package:dartz/dartz.dart';
import '../error/failure.dart';

/// put the Either.................
abstract class BaseUseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// extends the Equatable..........
class Noparams {
  const Noparams();
}
