import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enums.dart';
import '../../../domain/use_cases/add_new_product_category_use_case.dart';
import '../../../domain/use_cases/delete_product_category_use_case.dart';
import '../../../domain/use_cases/up_date_product_category_use_case.dart';
import 'categories_model_sheet_state.dart';

class CategoriesModelSheetCubit extends Cubit<CategoriesModelSheetState> {
  final AddNewProductCategoryUseCase addNewProductCategoryUseCase;
  final UpdateProductCategoryUseCase updateProductCategoryUseCase;
  final DeleteProductsCategoryUseCase deleteProductsCategoryUseCase;
  CategoriesModelSheetCubit(
    this.addNewProductCategoryUseCase,
    this.updateProductCategoryUseCase,
    this.deleteProductsCategoryUseCase,
  ) : super(const CategoriesModelSheetState());

  final categoryController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void takeCategoryName(String name) {
    categoryController.text = name;
  }

  Future<void> addNewCategory() async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(
        addCategoryState: RequestState.loading,
      ));
      final result = await addNewProductCategoryUseCase(
          AddNewProductsCategoryparams(name: categoryController.text));
      result.fold(
          (l) => emit(state.copyWith(
                addCategoryState: RequestState.error,
                message: l.message,
              )), (r) {
        categoryController.text = "";
        emit(state.copyWith(
          addCategoryState: RequestState.success,
        ));
      });
    }
  }

  Future<void> deleteCategory(
      DeleteProductsCategoryparams params) async {
    emit(state.copyWith(deleteCategoryState: RequestState.loading));
    final result = await deleteProductsCategoryUseCase(params);
    result.fold((l) {
      emit(state.copyWith(
          deleteCategoryState: RequestState.error, message: l.message));
    }, (r) {
      categoryController.text = "";
      emit(state.copyWith(deleteCategoryState: RequestState.success));
    });
  }

  Future<void> updateCategory(
      UpDateProductsCategoryparams params) async {
    if (formKey.currentState!.validate()) {
      emit(state.copyWith(updateCategoryState: RequestState.loading));
      final result = await updateProductCategoryUseCase(params);
      emit(result.fold(
          (l) => state.copyWith(
              updateCategoryState: RequestState.error,
              message: l.message), (r) {
        categoryController.text = "";
        return state.copyWith(updateCategoryState: RequestState.success);
      }));
    }
  }
}
