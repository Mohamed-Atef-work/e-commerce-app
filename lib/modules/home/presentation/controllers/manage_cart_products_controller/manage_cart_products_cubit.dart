import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/delete_product_from_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_cart_products_use_case.dart';
part 'manage_cart_products_state.dart';

class ManageCartProductsCubit extends Cubit<ManageCartProductsState> {
  final GetCartProductsUseCase _getCartProductsUseCase;
  final DeleteFromCartUseCase _deleteFromCartUseCase;
  final AddToCartUseCase _addToCartUseCase;

  ManageCartProductsCubit(
    this._getCartProductsUseCase,
    this._deleteFromCartUseCase,
    this._addToCartUseCase,
  ) : super(const ManageCartProductsState());

  Future<void> getCartProducts() async {
    if (state.needToReGet) {
      emit(state.copyWith(getCartState: RequestState.loading));

      /// Handling UID  :) ..........
      final result = await _getCartProductsUseCase(
          const GetCartProductsParams(uId: "uId"));
      emit(
        result.fold(
          (l) => state.copyWith(
              message: l.message, getCartState: RequestState.error),
          (r) {
            List<ProductEntity> products = [];
            for (CartEntity cart in r) {
              products.addAll(cart.products);
            }
            return state.copyWith(
              products: products,
              needToReGet: false,
              getCartState: RequestState.success,
            );
          },
        ),
      );
    }
  }

  Future<void> addToCart(AddToCartParams params) async {
    emit(state.copyWith(addState: RequestState.loading));
    final result = await _addToCartUseCase.call(params);
    emit(result.fold(
      (l) => state.copyWith(addState: RequestState.error, message: l.message),
      (r) => state.copyWith(addState: RequestState.success, needToReGet: true),
    ));
  }

  Future<void> deleteFromCart(DeleteFromCartParams params) async {
    emit(state.copyWith(deleteState: RequestState.loading));
    final result = await _deleteFromCartUseCase.call(params);
    emit(result.fold(
      (l) =>
          state.copyWith(deleteState: RequestState.error, message: l.message),
      (r) =>
          state.copyWith(deleteState: RequestState.success, needToReGet: true),
    ));
  }
}
