import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/get_all_product_categories.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/load_product_use_case.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class ProductsViewCubit extends Cubit<ProductsViewState> {
  final GetAllProductCategoriesUseCase getAllProductCategoriesUseCase;
  final LoadProductsUseCase loadProductsUseCase;

  StreamSubscription<List<ProductEntity>>? productsSub;
  StreamSubscription<List<ProductCategoryEntity>>? categorySub;

  ProductsViewCubit(
    this.loadProductsUseCase,
    this.getAllProductCategoriesUseCase,
  ) : super(const ProductsViewState());

  Future<void> loadCategories() async {
    await categorySub?.cancel();
    emit(state.copyWith(categoriesState: RequestState.loading));
    print("Categories -----------> ${state.categoriesState}");
    final result = await getAllProductCategoriesUseCase(const NoParams());
    result.fold(
        (l) => emit(
              state.copyWith(
                  categoriesState: RequestState.error, message: l.message),
            ), (stream) {
      categorySub = stream.listen((categories) {
        emit(
          state.copyWith(
              categoriesState: RequestState.success, categories: categories),
        );
        print("Categories -----------> ${state.categoriesState}");
      });
    });
  }

  Future<void> loadProducts() async {
    await productsSub?.cancel();
    emit(state.copyWith(productsState: RequestState.loading));
    print("products -----------> ${state.productsState}");

    final result = await loadProductsUseCase(
      LoadProductsParams(category: state.categories[state.categoryIndex].name),
    );
    result.fold(
        (l) => emit(
              state.copyWith(
                  productsState: RequestState.error, message: l.message),
            ), (stream) {
      productsSub = stream.listen((products) {
        emit(
          state.copyWith(
              productsState: RequestState.success, products: products),
        );
        print(" <----------- update -----------> ");

        print("products -----------> ${state.productsState}");
      });
    });
  }

  Future<void> loadProductsOfTheFirstCategory() async {
    await _loadFirstCat().then((value) async {
      await loadProducts();
    });
  }

  Future<List<ProductCategoryEntity>> _loadFirstCat() async {
    await categorySub?.cancel();
    final result = await getAllProductCategoriesUseCase(const NoParams());
    late Future<List<ProductCategoryEntity>> firstList;
    result.fold((l) => null, (stream) {
      firstList = stream.first;
    });
    return firstList;
  }

  void emitCategoryIndex(int index) {
    emit(state.copyWith(categoryIndex: index));
    loadProducts();
  }

  @override
  Future<void> close() async {
    await categorySub?.cancel();
    await productsSub?.cancel();
    return super.close();
  }
}
