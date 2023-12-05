import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/get_all_product_categories.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/load_product_use_case.dart';
import 'package:meta/meta.dart';

part 'home_screen_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllProductCategoriesUseCase getAllProductCategoriesUseCase;
  final LoadProductsUseCase loadProductsUseCase;
  HomeCubit(
    this.loadProductsUseCase,
    this.getAllProductCategoriesUseCase,
  ) : super(const HomeState());

  Future<void> loadProducts() async {
    emit(state.copyWith(productsState: RequestState.loading));
    final result = await loadProductsUseCase(LoadProductsParameters(
        category: state.categories[state.categoryIndex].name));
    result.fold((l) {
      emit(state.copyWith(
        productsState: RequestState.error,
        message: l.message,
      ));
    }, (stream) {
      stream.listen((products) {
        emit(state.copyWith(
            productsState: RequestState.success, products: products));
      });
    });
  }

  Future<void> loadCategories() async {
    emit(state.copyWith(categoriesState: RequestState.loading));
    final result = await getAllProductCategoriesUseCase(const NoParameters());
    result.fold((l) {
      emit(state.copyWith(
        categoriesState: RequestState.error,
        message: l.message,
      ));
    }, (stream) async {
      stream.listen((categories) {
        emit(state.copyWith(
          categoriesState: RequestState.success,
          categories: categories,
        ));
      });
    });
  }

  Future<void> loadProductsOfTheFirstCategory() async {
    await _loadFirstCat().then((value) async {
      await loadProducts();
    });
  }

  Future<List<ProductCategoryEntity>> _loadFirstCat() async {
    final stream = await getAllProductCategoriesUseCase(const NoParameters());
    late Future<List<ProductCategoryEntity>> firstList;
    stream.fold((l) => null, (r) {
      firstList = r.first;
    });
    return firstList;
  }

  void emitCategoryIndex(int index) {
    emit(state.copyWith(categoryIndex: index));
  }
}
