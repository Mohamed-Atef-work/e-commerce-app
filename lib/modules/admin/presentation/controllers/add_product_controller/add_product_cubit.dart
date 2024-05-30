import 'dart:async';
import 'dart:io';

import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final AddProductUseCase _addProductUseCase;
  final SharedDomainRepo _sharedRepo;

  AddProductCubit(
    this._addProductUseCase,
    this._sharedRepo,
  ) : super(const AddProductState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> newCategoryFormKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();

  StreamSubscription<List<ProductCategoryEntity>>? catsSub;

  void getCategories() async {
    emit(state.copyWith(getCategoriesState: RequestState.loading));
    await catsSub?.cancel();
    final result = _sharedRepo.getAllProductCategories();
    result.fold(
        (l) => emit(
              state.copyWith(
                getCategoriesState: RequestState.error,
              ),
            ), (stream) {
      catsSub = stream.listen((categories) {
        emit(state.copyWith(
          getCategoriesState: RequestState.success,
          categories: categories,
        ));
      });
    });
  }

  void addProduct() async {
    if (formKey.currentState!.validate() && state.thereIsImage) {
      emit(state.copyWith(productState: RequestState.loading));

      final params = AddProductParams(
        category: state.categories![state.categoryIndex].name,
        price: int.parse(priceController.text),
        description: descriptionController.text,
        name: nameController.text,
        image: File(state.imagePath!),
      );
      final result = await _addProductUseCase(params);
      emit(
        result.fold(
          (l) => state.copyWith(
            errorMessage: l.message,
            productState: RequestState.error,
          ),
          (r) => state.copyWith(
            productState: RequestState.success,
            thereIsImage: false,
            imagePath: "",
          ),
        ),
      );

      if (result.isRight()) {
        nameController.text = "";
        priceController.text = "";
        locationController.text = "";
        descriptionController.text = "";
        newCategoryController.text = "";
      }
    }
  }

  void getImageFromGallery() async {
    final result = await _sharedRepo.pickGalleryImage();
    emit(
      state.copyWith(
        imagePath: "",
        thereIsImage: false,
      ),
    );
    emit(
      result.fold(
        (l) => state.copyWith(errorMessage: l.message),
        (r) => state.copyWith(
          imagePath: r.path,
          thereIsImage: true,
        ),
      ),
    );
  }

  void categoryIndex(int index) => emit(state.copyWith(categoryIndex: index));

  @override
  Future<void> close() async {
    await catsSub?.cancel();
    return super.close();
  }
}
