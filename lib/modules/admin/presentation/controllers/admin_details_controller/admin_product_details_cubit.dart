import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enums.dart';
import '../../../domain/entities/product_entity.dart';
import '../../../domain/use_cases/delete_product_use_case.dart';
import '../../../domain/use_cases/load_product_use_case.dart';
import 'admin_product_details_state.dart';

class AdminDetailsCubit extends Cubit<AdminDetailsState> {
  final LoadProductsUseCase loadProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  AdminDetailsCubit(this.loadProductsUseCase, this.deleteProductUseCase)
      : super(const AdminDetailsState());

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

  Future<void> deleteProduct(DeleteProductParameters parameters) async {
    emit(state.copyWith(deleteState: RequestState.loading));
    final result = await deleteProductUseCase(parameters);
    result.fold(
      (l) => emit(
          state.copyWith(deleteState: RequestState.error, message: l.message)),
      (r) => emit(state.copyWith(
        deleteState: RequestState.success,
      )),
    );
  }
}
