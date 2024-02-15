import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/orders/data/model/item_model.dart';
import 'package:e_commerce_app/modules/auth/domain/entities/user_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/orders/data/model/order_data_model.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/orders/domain/use_case/add_order_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/clear_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_cart_products_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_product_quantities_of_cart_use_case.dart';

part 'manage_cart_products_state.dart';

class ManageCartProductsCubit extends Cubit<ManageCartProductsState> {
  final GetCartProductsQuantitiesUseCase _getCartProductsQuantitiesUseCase;
  final GetCartProductsUseCase _getCartProductsUseCase;
  final DeleteFromCartUseCase _deleteFromCartUseCase;
  final ClearCartUseCase _clearCartUseCase;
  final AddOrderUseCase _addOrderUseCase;

  ManageCartProductsCubit(
    this._getCartProductsQuantitiesUseCase,
    this._getCartProductsUseCase,
    this._deleteFromCartUseCase,
    this._clearCartUseCase,
    this._addOrderUseCase,
  ) : super(const ManageCartProductsState());

  Future<void> getCartProducts(String uId) async {
    if (state.needToReGet) {
      emit(state.copyWith(getCart: RequestState.loading));

      /// Handling UID  :) ..........
      final result =
          await _getCartProductsUseCase(GetCartProductsParams(uId: uId));

      result.fold(
        (l) {
          emit(state.copyWith(message: l.message, getCart: RequestState.error));
        },
        (r) {
          List<ProductEntity> products = [];
          for (CartEntity cart in r) {
            products.addAll(cart.products);
          }
          emit(
            state.copyWith(
              needToReGet: false,
              products: products,
              getCart: RequestState.success,
            ),
          );
          print(state.products.length);
          //List<int> quantities = List.generate(products.length, (index) => 1);

          if (state.products.isNotEmpty) {
            getQuantities(uId);
          }
        },
      );
    }
  }

  Future<void> getQuantities(String uId) async {
    emit(state.copyWith(getProductsQuantities: RequestState.loading));
    final productsParams = List.generate(
      state.products.length,
      (index) => GetQuantities(
          id: state.products[index].id!,
          category: state.products[index].category),
    );

    final result = await _getCartProductsQuantitiesUseCase.call(
      GetQuantitiesParams(
        productsParams: productsParams,
        uId: uId,
      ),
    );
    emit(
      result.fold(
        (l) => state.copyWith(
            message: l.message, getProductsQuantities: RequestState.error),
        (r) => state.copyWith(
            quantities: r, getProductsQuantities: RequestState.success),
      ),
    );
    print(
        " _________________________________ ${state.quantities.length} _________________________________");
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

  Future<void> clearCart(String uId) async {
    emit(state.copyWith(clearCart: RequestState.loading));

    final clearCartParams = ClearCartParams(
      params: List.generate(
        state.products.length,
        (index) => DeleteFromCartParams(
          productId: state.products[index].id!,
          category: state.products[index].category,
          uId: uId,
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

  Future<void> addOrder(UserEntity user) async {
    emit(state.copyWith(addOrder: RequestState.loading));

    final totalPrice = _totalPrice();

    final items = _makeItems();

    final result = await _addOrderUseCase.call(
      AddOrderParams(
        items: items,
        uId: user.id,
        orderData: OrderDataModel(
          name: user.name,
          phone: user.phone!,
          address: user.address!,
          totalPrice: totalPrice,
          date: DateTime.now().toString(),
        ),
      ),
    );

    result.fold((l) {
      emit(state.copyWith(addOrder: RequestState.error, message: l.message));
    }, (r) async {
      emit(state.copyWith(addOrder: RequestState.success, needToReGet: true));
      await clearCart(user.id);
    });
  }

  double _totalPrice() {
    double totalPrice = 0;
    for (int index = 0; index < state.products.length; index++) {
      totalPrice =
          totalPrice + state.quantities[index] * state.products[index].price;
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
