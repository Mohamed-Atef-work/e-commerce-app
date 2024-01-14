import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/modules/home/presentation/screens/details_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final AddToCartUseCase _addToCartUseCase;

  /// To Do
  /// You provided this cubit on the top of [ProductsOfCategoryScreen]....
  /// NOT [DetailsScreen]....
  ///
  ProductDetailsCubit(this._addToCartUseCase)
      : super(const ProductDetailsState());

  Future<void> addToCart({required String uId}) async {
    emit(state.copyWith(addToCart: RequestState.loading));
    final result = await _addToCartUseCase.call(
      AddToCartParams(
        category: state.product!.category,
        productId: state.product!.id!,
        quantity: state.quantity,
        uId: uId,
      ),
    );
    emit(
      result.fold(
        (l) =>
            state.copyWith(addToCart: RequestState.error, message: l.message),
        (r) => state.copyWith(addToCart: RequestState.success),
      ),
    );
  }

  void product(ProductEntity product) {
    emit(state.copyWith(product: product));
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
