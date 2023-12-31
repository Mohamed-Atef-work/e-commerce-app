import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/home/domain/entities/cart_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/get_cart_products_use_case.dart';
part 'get_cart_products_state.dart';

class GetCartProductsCubit extends Cubit<GetCartProductsState> {
  final GetCartProductsUseCase _getCartProductsUseCase;
  GetCartProductsCubit(this._getCartProductsUseCase)
      : super(const GetCartProductsState());
  Future<void> getCartProducts() async {
    emit(state.copyWith(getCartState: RequestState.loading));

    /// Handling UID  :) ..........
    final result =
        await _getCartProductsUseCase(const GetCartProductsParams(uId: "uId"));
    emit(
      result.fold(
        (l) => state.copyWith(
            message: l.message, getCartState: RequestState.error),
        (r) => state.copyWith(getCartState: RequestState.success, products: r),
      ),
    );
  }
}
