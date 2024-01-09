import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_cart_products_use_case.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
part 'manage_cart_products_state.dart';

class ManageCartProductsCubit extends Cubit<ManageCartProductsState> {
  final GetCartProductsUseCase _getCartProductsUseCase;
  final DeleteFromCartUseCase _deleteFromCartUseCase;
  final AddToCartUseCase _addToCartUseCase;
  final AddOrderUseCase _addOrderUseCase;

  ManageCartProductsCubit(
    this._getCartProductsUseCase,
    this._deleteFromCartUseCase,
    this._addToCartUseCase,
    this._addOrderUseCase,
  ) : super(const ManageCartProductsState());

  Future<void> getCartProducts() async {
    if (state.needToReGet) {
      emit(state.copyWith(getCart: RequestState.loading));

      /// Handling UID  :) ..........
      final result = await _getCartProductsUseCase(
          const GetCartProductsParams(uId: "uId"));
      emit(
        result.fold(
          (l) =>
              state.copyWith(message: l.message, getCart: RequestState.error),
          (r) {
            List<ProductEntity> products = [];
            for (CartEntity cart in r) {
              products.addAll(cart.products);
            }
            List<int> quantities = List.generate(products.length, (index) => 1);
            return state.copyWith(
              needToReGet: false,
              products: products,
              quantities: quantities,
              getCart: RequestState.success,
            );
          },
        ),
      );
    }
  }

  Future<void> addToCart(AddToCartParams params) async {
    emit(state.copyWith(addToCart: RequestState.loading));
    final result = await _addToCartUseCase.call(params);
    emit(result.fold(
      (l) => state.copyWith(addToCart: RequestState.error, message: l.message),
      (r) => state.copyWith(addToCart: RequestState.success, needToReGet: true),
    ));
  }

  Future<void> deleteFromCart(DeleteFromCartParams params) async {
    emit(state.copyWith(deleteFromCart: RequestState.loading));
    final result = await _deleteFromCartUseCase.call(params);
    emit(result.fold(
      (l) => state.copyWith(
          deleteFromCart: RequestState.error, message: l.message),
      (r) => state.copyWith(
          deleteFromCart: RequestState.success, needToReGet: true),
    ));
  }

  Future<void> addOrder() async {
    emit(state.copyWith(addOrder: RequestState.loading));

    double totalPrice = 0;
    for (int index = 0; index < state.products.length; index++) {
      totalPrice = totalPrice +
          state.quantities[index] * double.parse(state.products[index].price);
    }

    final items = List.generate(
      state.products.length,
      (index) => OrderItemModel(
        product: state.products[index],
        quantity: state.quantities[index],
      ),
    );

    final result = await _addOrderUseCase.call(
      AddOrderParams(
        items: items,
        orderData: OrderDataModel(
          date: "date",
          name: "name",
          phone: "phone",
          totalPrice: totalPrice.toString(),
          address: "address",
        ),
        uId: "uId",
      ),
    );

    emit(result.fold(
      (l) => state.copyWith(addOrder: RequestState.error, message: l.message),
      (r) => state.copyWith(addOrder: RequestState.success),
    ));
  }

  void quantityPlus(int index) {
    state.quantities[index]++;
    emit(state.copyWith());
  }

  void quantityMinus(int index) {
    if (state.quantities[index] > 1) {
      state.quantities[index]--;
    }
    emit(state.copyWith());
  }
}
