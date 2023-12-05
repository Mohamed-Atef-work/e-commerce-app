import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../admin/domain/use_cases/load_product_use_case.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final LoadProductsUseCase loadProductsUseCase;
  ProductDetailsCubit(this.loadProductsUseCase)
      : super(const ProductDetailsState());

  void emitProduct(ProductEntity product) {
    emit(state.copyWith(selectedProduct: product));
  }

  void emitSelectedProduct(int index) {
    emit(state.copyWith(selectedProduct: state.products![index]));
  }

  Future<void> loadProducts(String category) async {
    emit(state.copyWith(
      productsState: RequestState.loading,
    ));
    final result = await loadProductsUseCase(
      LoadProductsParameters(
        category: category,
      ),
    );
    result.fold(
        (failure) => emit(state.copyWith(
              productsState: RequestState.error,
              message: failure.message,
            )), (stream) {
      stream.listen((products) {
        emit(state.copyWith(
            productsState: RequestState.success, products: products));
      });
    });
  }
}
