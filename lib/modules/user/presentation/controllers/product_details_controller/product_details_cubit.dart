import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/user/domain/params/add_product_to_cart_params.dart';
import 'package:e_commerce_app/modules/user/domain/repository/cart_domain_repository.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final CartDomainRepo _cartRepo;

  ProductDetailsCubit(this._cartRepo) : super(const ProductDetailsState());

  void addToCart(String uId) async {
    emit(state.copyWith(addToCart: RequestState.loading));
    print(state.product!.category);
    final result = await _cartRepo.addToCart(
      AddToCartParams(
        uId: uId,
        quantity: state.quantity,
        productId: state.product!.id!,
        category: state.product!.category,
      ),
    );
    emit(
      result.fold(
        (l) =>
            state.copyWith(addToCart: RequestState.error, message: l.message),
        (r) => state.copyWith(addToCart: RequestState.success),
      ),
    );

    Future.delayed(
        const Duration(
          milliseconds: 30,
        ), () {
      emit(state.copyWith(addToCart: RequestState.initial));
    });
  }

  void product(ProductEntity product) {
    emit(state.copyWith(product: product));
  }

  void reset() {
    emit(state.copyWith(
        message: "", quantity: 1, addToCart: RequestState.initial));
  }

  void quantityPlus() {
    int quantity = state.quantity + 1;
    emit(state.copyWith(quantity: quantity));
  }

  void quantityMinus() {
    if (state.quantity > 1) {
      int quantity = state.quantity - 1;
      emit(state.copyWith(quantity: quantity));
    }
  }
}
