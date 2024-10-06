import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/modules/user/domain/repository/payment.dart';
import 'package:e_commerce_app/modules/user/data/data_source/payment_data_source.dart';

class PaymentRepoImpl implements PaymentRepo {
  final PaymentDataSource _dataSource;

  PaymentRepoImpl(this._dataSource);
  @override
  Future<Either<Failure, void>> pay(PayParams params) async {
    try {
      final result = await _dataSource.pay(params);
      return Right(result);
    } on ServerException catch (exception) {
      final failure = ServerFailure(message: exception.message);
      return Left(failure);
    }
  }
}
