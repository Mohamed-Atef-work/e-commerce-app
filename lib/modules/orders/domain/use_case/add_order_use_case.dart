import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/error/failure.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/clear_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/repository/cart_domain_repository.dart';
import 'package:e_commerce_app/modules/orders/domain/repository/order_domain_repository.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';

class AddOrderUseCase extends BaseUseCase<void, AddOrderParams> {
  final OrderDomainRepo _orderRepo;
  final CartDomainRepo _cartRepo;

  AddOrderUseCase(this._orderRepo, this._cartRepo);
  @override
  Future<Either<Failure, void>> call(AddOrderParams params) async {
    final clearParams = ClearCartParams(
      params: List.generate(
        params.items.length,
        (index) => DeleteFromCartParams(
          uId: params.uId,
          productId: params.items[index].product.id!,
          category: params.items[index].product.category,
        ),
      ),
    );
    final orderEither = await _orderRepo.addOrder(params);

    return orderEither.fold(
      (addOrderFailure) => Left(addOrderFailure),
      (r) async => await _cartRepo.clearCart(clearParams),
    );
  }
}

class AddOrderParams {
  final List<OrderItemModel> items;
  final OrderDataModel orderData;
  final String uId;

  AddOrderParams({
    required this.items,
    required this.orderData,
    required this.uId,
  });
}
