import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/enums.dart';
import '../../../domain/params/add_new_product_category_params.dart';
import '../../../domain/params/delete_product_category_params.dart';
import '../../../domain/params/up_date_product_category_params.dart';
import 'categories_model_sheet_state.dart';

class CategoriesModelSheetCubit extends Cubit<CategoriesModelSheetState> {
  final AdminRepositoryDomain adminRepo;
  CategoriesModelSheetCubit(this.adminRepo)
      : super(const CategoriesModelSheetState());

  final categoryController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void takeCategoryName(String name) {
    categoryController.text = name;
  }

  void addNewCategory() async {
    if (formKey.currentState!.validate()) {
      emit(
        state.copyWith(addCategoryState: RequestState.loading),
      );
      final result = await adminRepo.addNewProductCategory(
          AddNewProductsCategoryParams(name: categoryController.text));
      emit(
        result.fold(
          (l) => state.copyWith(
              addCategoryState: RequestState.error, message: l.message),
          (r) => state.copyWith(addCategoryState: RequestState.success),
        ),
      );

      if (result.isRight()) {
        categoryController.text = "";
      }
    }
  }

  void deleteCategory(DeleteProductsCategoryParams params) async {
    emit(
      state.copyWith(categoryState: RequestState.loading),
    );
    final result = await adminRepo.deleteProductCategory(params);
    emit(
      result.fold(
        (l) => state.copyWith(
            categoryState: RequestState.error, message: l.message),
        (r) => state.copyWith(categoryState: RequestState.success),
      ),
    );

    if (result.isRight()) {
      categoryController.text = "";
    }
  }

  void updateCategory(UpDateProductsCategoryParams params) async {
    if (formKey.currentState!.validate()) {
      emit(
        state.copyWith(categoryState: RequestState.loading),
      );
      final result = await adminRepo.upDateProductCategory(params);
      emit(
        result.fold(
          (l) => state.copyWith(
              categoryState: RequestState.error, message: l.message),
          (r) => state.copyWith(categoryState: RequestState.success),
        ),
      );

      if (result.isRight()) {
        categoryController.text = "";
      }
    }
  }
}
