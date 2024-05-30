import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_category_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/update_product_with_new_image_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/update_product_without_new_image_use_case.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/edit_product_controller/edit_product_state.dart';

class EditProductCubit extends Cubit<EditProductState> {
  final UpdateProductWithOutNewImageUseCase _updateWithoutImage;
  final UpdateProductWithNewImageUseCase _updateWithImage;
  final AdminRepositoryDomain _adminRepo;
  final SharedDomainRepo _sharedRepo;

  EditProductCubit(
    this._adminRepo,
    this._sharedRepo,
    this._updateWithImage,
    this._updateWithoutImage,
  ) : super(const EditProductState());

  StreamSubscription<List<ProductCategoryEntity>>? catsSub;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> newCategoryFormKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void init(ProductEntity productToBeUpdated) {
    emit(
      state.copyWith(
        imageState: ImageState.network,
        productToBeUpdated: productToBeUpdated,
      ),
    );
    nameController.text = productToBeUpdated.name;
    priceController.text = productToBeUpdated.price.toString();
    descriptionController.text = productToBeUpdated.description;
  }

  void getCategories() async {
    emit(
      state.copyWith(getCategoriesState: RequestState.loading),
    );
    await catsSub?.cancel();
    final result = _sharedRepo.getAllProductCategories();
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        result.fold(
          (l) => emit(
            state.copyWith(
              errorMessage: l.message,
              getCategoriesState: RequestState.error,
            ),
          ),
          (stream) {
            catsSub = stream.listen(
              (categories) {
                emit(
                  state.copyWith(
                    categories: categories,
                    getCategoriesState: RequestState.success,
                  ),
                );
                Future.delayed(
                  const Duration(milliseconds: 100),
                  () => emit(
                    state.copyWith(getCategoriesState: RequestState.initial),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void update() async {
    if (formKey.currentState!.validate()) {
      if (state.imageState == ImageState.network) {
        print("_notChangedImage()");
        _notChangedImage();
      } else if (state.imageState == ImageState.local) {
        print("_changedImage()");

        _changedImage();
      }
    } else {
      print(
          "< ------------------- Not Validate or No Image ------------------- >");
    }
  }

  void categoryIndex(int index) => emit(state.copyWith(categoryIndex: index));

  void setCategory() {
    for (int i = 0; i < state.categories!.length; i++) {
      if (state.productToBeUpdated!.category == state.categories![i].name) {
        categoryIndex(i);
        return;
      }
    }
    emit(
      state.copyWith(
        productState: RequestState.error,
        errorMessage: AppStrings.outOfStockOrCategoryChanged,
      ),
    );
  }

  void _changedImage() async {
    emit(state.copyWith(productState: RequestState.loading));

    final params = _changedImageParams();

    final result = await _updateWithImage(params);
    emit(
      result.fold(
        (l) => state.copyWith(
          errorMessage: l.message,
          productState: RequestState.error,
        ),
        (productId) => state.copyWith(
          productId: productId,
          imageState: ImageState.noImage,
          productState: RequestState.success,
        ),
      ),
    );
  }

  void _notChangedImage() async {
    final isCatChanged = _isCatChanged();

    if (isCatChanged) {
      print("_notChangedCat()");

      _notChangedCat();
    } else {
      print("_changedCat()");

      _changedCat();
    }
  }

  void _changedCat() async {
    emit(state.copyWith(productState: RequestState.loading));

    final params = _updateProductParams();

    final result = await _updateWithoutImage(params);
    emit(
      result.fold(
        (l) => state.copyWith(
          errorMessage: l.message,
          productState: RequestState.error,
        ),
        (productId) => state.copyWith(
          productId: productId,
          imageState: ImageState.noImage,
          productState: RequestState.success,
        ),
      ),
    );
  }

  void _notChangedCat() async {
    emit(state.copyWith(productState: RequestState.loading));

    final params = _updateProductParams();

    final result = await _adminRepo.editProduct(params);
    emit(
      result.fold(
        (l) => state.copyWith(
          errorMessage: l.message,
          productState: RequestState.error,
        ),
        (r) => state.copyWith(
          imageState: ImageState.noImage,
          productState: RequestState.success,
          productId: state.productToBeUpdated!.id,
        ),
      ),
    );
  }

  void getImageFromGallery() async {
    emit(
      state.copyWith(
        imagePath: "",
        imageState: ImageState.noImage,
      ),
    );
    final result = await _sharedRepo.pickGalleryImage();

    emit(
      result.fold(
        (l) => state.copyWith(errorMessage: l.message),
        (r) => state.copyWith(imagePath: r.path, imageState: ImageState.local),
      ),
    );
  }

  _updateProductParams() => UpdateProductParams(
        product: ProductModel(
          name: nameController.text,
          id: state.productToBeUpdated!.id!,
          price: int.parse(priceController.text),
          image: state.productToBeUpdated!.image,
          description: descriptionController.text,
          category: state.productToBeUpdated!.category,
        ),
        newCat: state.categories![state.categoryIndex!].name,
      );

  _changedImageParams() => UpdateProductWithNewImageParams(
        newCat: state.categories![state.categoryIndex!].name,
        imageFile: File(state.imagePath!),
        product: ProductModel(
          category: state.productToBeUpdated!.category,
          description: descriptionController.text,
          price: int.parse(priceController.text),
          image: state.productToBeUpdated!.image,
          id: state.productToBeUpdated!.id,
          name: nameController.text,
        ),
      );

  bool _isCatChanged() {
    final selectedCategory = state.categories![state.categoryIndex!].name;
    final productCategory = state.productToBeUpdated!.category;
    if (selectedCategory == productCategory) {
      return true;
    }
    return false;
  }

  @override
  Future<void> close() async {
    await catsSub?.cancel();
    return super.close();
  }
}
