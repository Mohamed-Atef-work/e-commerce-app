import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/shared/domain/use_cases/load_product_params.dart';
import 'package:meta/meta.dart';

part 'products_view_state.dart';

class ProductsViewCubit extends Cubit<ProductsViewState> {
  final AdminRepositoryDomain adminRepo;
  final SharedDomainRepo _sharedRepo;

  StreamSubscription<List<ProductEntity>>? productsSub;
  StreamSubscription<List<ProductCategoryEntity>>? categorySub;

  ProductsViewCubit(
    this._sharedRepo,
    this.adminRepo,
  ) : super(const ProductsViewState());

  void loadCategories() async {
    await categorySub?.cancel();
    emit(state.copyWith(categoriesState: RequestState.loading));
    print("Categories -----------> ${state.categoriesState}");
    final result = _sharedRepo.getAllProductCategories();
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

  void loadProducts() async {
    emit(state.copyWith(productsState: RequestState.loading));
    await productsSub?.cancel();
    Future.delayed(const Duration(seconds: 1), () {
      print("products -----------> ${state.productsState}");

      final result = _sharedRepo.loadProducts(
        LoadProductsParams(
            category: state.categories[state.categoryIndex].name),
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
    });
  }

  void loadProductsOfTheFirstCategory() async {
    await _loadFirstCat().then((value) async {
      loadProducts();
    });
  }

  Future<List<ProductCategoryEntity>> _loadFirstCat() async {
    await categorySub?.cancel();
    final result = _sharedRepo.getAllProductCategories();
    late Future<List<ProductCategoryEntity>> firstList;
    result.fold((l) => null, (stream) {
      firstList = stream.first;
    });
    return firstList;
  }

  void emitCategoryIndex(int index) async {
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
