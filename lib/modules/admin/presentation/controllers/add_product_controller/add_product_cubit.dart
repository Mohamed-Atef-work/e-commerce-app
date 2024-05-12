import 'dart:io';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/repository/admin_domain_repository.dart';
import 'package:e_commerce_app/modules/shared/domain/repository/shared_domain_repo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/use_cases/add_product_use_case.dart';
import 'add_product_state.dart';

class EditAddProductCubit extends Cubit<EditAddProductState> {
  final AddProductUseCase addProductUseCase;
  final AdminRepositoryDomain adminRepo;
  final SharedDomainRepo sharedRepo;

  EditAddProductCubit(
    this.addProductUseCase,
    this.adminRepo,
    this.sharedRepo,
  ) : super(const EditAddProductState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> newCategoryFormKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController newCategoryController = TextEditingController();

  Future<void> getCategories() async {
    emit(state.copyWith(getCategoriesState: RequestState.loading));
    final result = adminRepo.getAllProductCategories();
    result.fold(
        (l) => emit(
              state.copyWith(
                getCategoriesState: RequestState.error,
              ),
            ), (stream) {
      stream.listen((categories) {
        emit(state.copyWith(
          getCategoriesState: RequestState.success,
          categories: categories,
        ));
      });
    });
  }

  void decideAddOrUpdate(ProductEntity? productToBeUpdated) {
    if (productToBeUpdated != null) {
      emit(
        state.copyWith(
          thereIsImage: true,
          imageState: ImageState.network,
          addUpdateButtonText: AppStrings.update,
          productToBeUpdated: productToBeUpdated,
          imageButtonText: AppStrings.changeTheImage,
        ),
      );
      nameController.text = productToBeUpdated.name;
      priceController.text = productToBeUpdated.price.toString();
      locationController.text = productToBeUpdated.location;
      descriptionController.text = productToBeUpdated.description;
    }
  }

  void categoryIndex(int index) {
    emit(state.copyWith(categoryIndex: index));
  }

  Future<void> execute() async {
    print(" < ------------------------- execute ------------------------- > ");

    if (formKey.currentState!.validate() && state.thereIsImage) {
      /// < ------------------------------------------------------------------ >

      emit(state.copyWith(productState: RequestState.loading));

      /// < ------------------------------------------------------------------ >

      if (state.imageState == ImageState.network) {
        await _upDateProduct(
          productImage: state.productToBeUpdated!.image,
        );
      } else {
        await _imagePart();
      }
    } else {
      print(
          "< ------------------- Not Validate or No Image ------------------- >");
    }
  }

  Future<void> _upDateProduct({required String productImage}) async {
    print(
        "< -------------------------------------------_upDateProduct----------------------------------------------- >");
    final result = await adminRepo.addProduct(
      AddProductParams(
          product: ProductModel(
        image: productImage,
        name: nameController.text,
        id: state.productToBeUpdated!.id!,
        location: locationController.text,
        price: int.parse(priceController.text),
        description: descriptionController.text,
        category: state.categories![state.categoryIndex].name,
      )),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          productState: RequestState.error,
          errorMessage: l.message,
        ),
      ),
      (r) {
        emit(state.copyWith(
          imageButtonText: AppStrings.addAnImage,
          addUpdateButtonText: AppStrings.add,
          productState: RequestState.success,
          imageState: ImageState.noImage,
          thereIsImage: false,
        ));
        nameController.text = "";
        priceController.text = "";
        locationController.text = "";
        descriptionController.text = "";
      },
    );
  }

  Future<void> _addProduct(String imageUrl) async {
    print(
        "< -------------------------------------------_addProduct----------------------------------------------- >");
    final addProductResult = await addProductUseCase(
      AddProductParams(
        product: ProductModel(
          category: state.categories![state.categoryIndex].name,
          price: int.parse(priceController.text),
          description: descriptionController.text,
          location: locationController.text,
          name: nameController.text,
          image: imageUrl,
        ),
      ),
    );

    /// < -------------------------------------------------------------------- >
    addProductResult.fold((l) {
      emit(
        state.copyWith(
          errorMessage: l.message,
          productState: RequestState.error,
        ),
      );
    }, (r) {
      emit(
        state.copyWith(
          thereIsImage: false,
          imageState: ImageState.noImage,
          productState: RequestState.success,
          imageButtonText: AppStrings.addAnImage,
        ),
      );
      nameController.text = "";
      priceController.text = "";
      locationController.text = "";
      descriptionController.text = "";
      print("< _________ imagePath is ________ ${state.imagePath} _________ >");
      print("< ________ productState is _______ ${state.productState} _____ >");
    });
  }

  Future<void> _imagePart() async {
    print("< ------------------------ _imagePart ------------------------- >");
    final uploadImageResult =
        await sharedRepo.uploadImage(File(state.imagePath!));

    ///< ------------------------------------------------------------------- >

    uploadImageResult.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
                productState: RequestState.error,
                uploadImageState: RequestState.error,
              ),
            ), (imageReference) async {
      emit(
        state.copyWith(uploadImageState: RequestState.success),
      );
      print(
          "< _____ uploadImageState is ______ ${state.uploadImageState} ______ >");

      /// < ---------------------------------------------------------------- >
      _downloadUrlPart(imageReference);
    });
  }

  Future<void> _downloadUrlPart(Reference imageReference) async {
    print(
        "< ---------------------------- _downloadUrlPart -------------------- >");

    /// < -------------------------------------------------------------------- >
    final downloadUrlResult = await sharedRepo.downloadImageUrl(imageReference);

    /// < ------------------------------------------------------------------- >
    downloadUrlResult.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
                productState: RequestState.error,
                downloadImageState: RequestState.error,
              ),
            ), (imageUrl) async {
      emit(state.copyWith(downloadImageState: RequestState.success));
      print(
          "< _____ downloadImageState is ____ ${state.downloadImageState} ____ >");
      if (state.addUpdateButtonText == AppStrings.update) {
        await _upDateProduct(productImage: imageUrl);
      } else {
        await _addProduct(imageUrl);
      }
    });
  }

  Future<void> getImageFromGallery() async {
    print(
        "< -------------------------getImageFromGallery------------------------- >");
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    emit(state.copyWith(imageState: ImageState.noImage));
    if (pickedFile != null) {
      emit(
        state.copyWith(
          imageButtonText: AppStrings.changeTheImage,
          imageState: ImageState.local,
          imagePath: pickedFile.path,
          thereIsImage: true,
        ),
      );

      // A file was picked; you can use pickedFile.path to get the file path.
      // For example, you can display the image using an Image widget:
      // Image.file(File(pickedFile.path));
      // Remember to import 'dart:io'.
    } else {
      // The user canceled the picker.
    }
  }
}
