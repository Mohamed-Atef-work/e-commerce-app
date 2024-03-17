import 'package:e_commerce_app/core/constants/strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/load_product_use_case.dart';

import '../../../../../core/utils/enums.dart';
import 'explore_product_state.dart';

class ExploreProductsCubit extends Cubit<ExploreProductsState> {
  /*final DeleteProductUseCase deleteProductUseCase;*/
  final LoadProductsUseCase loadProductsUseCase;

  ExploreProductsCubit(
    //this.deleteProductUseCase,
    this.loadProductsUseCase,
  ) : super(const ExploreProductsState());

  Future<void> shirtsStream() async {
    final result = await loadProductsUseCase(
      const LoadProductsParams(
        category: kShirts,
      ),
    );
    result.fold(
      (l) => emit(state.copyWith(
        shirtsState: RequestState.error,
        errorMessage: l.message,
      )),
      (stream) {
        stream.listen((shirts) => emit(
            state.copyWith(shirtsState: RequestState.success, shirts: shirts)));
      },
    );
  }

  Future<void> jacketsStream() async {
    final result = await loadProductsUseCase(
      const LoadProductsParams(
        category: kJackets,
      ),
    );
    result.fold(
      (l) => emit(state.copyWith(
        jacketsState: RequestState.error,
        errorMessage: l.message,
      )),
      (stream) {
        stream.listen((jackets) => emit(state.copyWith(
            jacketsState: RequestState.success, jackets: jackets)));
      },
    );
  }

  /*Future<void> deleteProduct(DeleteProductParams params) async {
    final result = await deleteProductUseCase(params);
    result.fold(
      (l) => emit(state.copyWith(
          deleteProductState: RequestState.error, errorMessage: l.message)),
      (r) => emit(state.copyWith(
        deleteProductState: RequestState.success,
      )),
    );
  }*/
}
