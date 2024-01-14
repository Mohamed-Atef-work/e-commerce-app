import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/clear_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_cart_products_use_case.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
part 'manage_cart_products_state.dart';

class ManageCartProductsCubit extends Cubit<ManageCartProductsState> {
  final GetCartProductsUseCase _getCartProductsUseCase;
  final DeleteFromCartUseCase _deleteFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final AddOrderUseCase _addOrderUseCase;

  ManageCartProductsCubit(
    this._getCartProductsUseCase,
    this._deleteFromCartUseCase,
    this._addOrderUseCase,
    this._clearCartUseCase,
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

  Future<void> clearCart() async {
    emit(state.copyWith(clearCart: RequestState.loading));

    final clearCartParams = ClearCartParams(
      params: List.generate(
        state.products.length,
        (index) => DeleteFromCartParams(
          productId: state.products[index].id!,
          category: state.products[index].category,
          uId: "uId",
        ),
      ),
    );

    final result = await _clearCartUseCase.call(clearCartParams);
    emit(
      result.fold(
        (l) =>
            state.copyWith(clearCart: RequestState.error, message: l.message),
        (r) => state.copyWith(
          clearCart: RequestState.success,
          products: const [],
          needToReGet: true,
        ),
      ),
    );
  }

  Future<void> addOrder() async {
    emit(state.copyWith(addOrder: RequestState.loading));

    final totalPrice = _totalPrice();

    final items = _makeItems();

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

    result.fold((l) {
      emit(state.copyWith(addOrder: RequestState.error, message: l.message));
    }, (r) async {
      emit(state.copyWith(addOrder: RequestState.success, needToReGet: true));
      await clearCart();
    });
  }

  double _totalPrice() {
    double totalPrice = 0;
    for (int index = 0; index < state.products.length; index++) {
      totalPrice = totalPrice +
          state.quantities[index] * double.parse(state.products[index].price);
    }
    return totalPrice;
  }

  List<OrderItemModel> _makeItems() {
    return List.generate(
      state.products.length,
      (index) => OrderItemModel(
        product: state.products[index],
        quantity: state.quantities[index],
      ),
    );
  }

  void needToReGet() {
    emit(state.copyWith(needToReGet: true));
  }

  void quantityPlus(int index) {
    state.quantities[index]++;
    emit(state.copyWith());
  }

  void quantityMinus(int index) {
    if (state.quantities[index] > 1) {
      state.quantities[index]--;
      emit(state.copyWith());
    }
  }
}
