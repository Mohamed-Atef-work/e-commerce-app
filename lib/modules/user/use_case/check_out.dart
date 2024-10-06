import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/user/domain/repository/payment.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';

class CheckoutUseCase extends BaseUseCase<void, CheckoutParams> {
  final PaymentRepo _paymentRepo;
  final AddOrderUseCase _addOrderUseCase;

  CheckoutUseCase(this._paymentRepo, this._addOrderUseCase);
  @override
  Future<Either<Failure, void>> call(CheckoutParams params) async {
    final paymentEither = await _paymentRepo.pay(params.paymentParams);
    return paymentEither.fold(
      (paymentFailure) => Left(paymentFailure),
      (paymentSuccess) async => await _addOrderUseCase(params.orderParams),
    );
  }
}

class CheckoutParams {
  final AddOrderParams orderParams;
  final PayParams paymentParams;

  CheckoutParams({
    required this.orderParams,
    required this.paymentParams,
  });
}
