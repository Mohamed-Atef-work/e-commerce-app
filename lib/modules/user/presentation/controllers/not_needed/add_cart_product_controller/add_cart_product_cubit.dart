import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/user/domain/params/add_product_to_cart_params.dart';

part 'add_cart_product_state.dart';

/*class AddCartProductCubit extends Cubit<AddToCartProductState> {
  final AddToCartUseCase _addToCartUseCase;
  AddCartProductCubit(this._addToCartUseCase)
      : super(const AddToCartProductState());

  Future<void> addToCart(AddToCartParams params) async {
    emit(state.copyWith(addState: RequestState.loading));
    final result = await _addToCartUseCase.call(params);
    emit(
      result.fold(
        (l) => state.copyWith(addState: RequestState.error, message: l.message),
        (r) => state.copyWith(addState: RequestState.success),
      ),
    );
  }
}*/
