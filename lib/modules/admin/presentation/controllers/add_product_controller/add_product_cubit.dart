import 'dart:io';

import 'package:e_commerce_app/core/use_case/base_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/get_all_product_categories.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/download_product_image_url_use_case.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/upload_product_image_use_case.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/use_cases/add_product_use_case.dart';
import '../../../domain/use_cases/edit_product_use_case.dart';
import 'add_product_state.dart';

class EditAddProductCubit extends Cubit<EditAddProductState> {
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final UploadProductImageUseCase uploadProductImageUseCase;
  //final AddNewProductCategoryUseCase addNewProductCategoryUseCase;
  final DownloadProductImageUrlUseCase downloadProductImageUrlUseCase;
  final GetAllProductCategoriesUseCase getAllProductCategoriesUseCase;
  EditAddProductCubit(
    this.addProductUseCase,
    this.updateProductUseCase,
    this.uploadProductImageUseCase,
    //this.addNewProductCategoryUseCase,
    this.getAllProductCategoriesUseCase,
    this.downloadProductImageUrlUseCase,
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
    final result = await getAllProductCategoriesUseCase(const NoParameters());
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
          imageButtonText: AppStrings.changeTheImage,
          addUpdateButtonText: AppStrings.update,
          productToBeUpdated: productToBeUpdated,
        ),
      );
      nameController.text = productToBeUpdated.name;
      priceController.text = productToBeUpdated.price.toString();
      //categoryController.text = productToBeUpdated.category;
      locationController.text = productToBeUpdated.location;
      descriptionController.text = productToBeUpdated.description;
    }
  }

  void categoryIndex(int index) {
    emit(state.copyWith(categoryIndex: index));
  }

  Future<void> execute() async {
    print(
        "< -------------------------------------------execute----------------------------------------------- >");

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
          "< -------------------- Not Validate or No Image ------------------- >");
    }
  }

  Future<void> _upDateProduct({required String productImage}) async {
    print(
        "< -------------------------------------------_upDateProduct----------------------------------------------- >");
    final result = await updateProductUseCase(
      UpdateProductParameters(
        productDescription: descriptionController.text,
        productId: state.productToBeUpdated!.id!,
        productCategory: state.categories![state.categoryIndex].name,
        productLocation: locationController.text,
        productPrice: priceController.text,
        productName: nameController.text,
        productImage: productImage,
      ),
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
        //categoryController.text = "";
        locationController.text = "";
        descriptionController.text = "";
      },
    );
  }

  Future<void> _addProduct(String imageUrl) async {
    print(
        "< -------------------------------------------_addProduct----------------------------------------------- >");
    final addProductResult = await addProductUseCase(
      AddProductParameters(
        productDescription: descriptionController.text,
        productCategory: state.categories![state.categoryIndex].name,
        productLocation: locationController.text,
        productPrice: priceController.text,
        productName: nameController.text,
        productImage: imageUrl,
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
          productState: RequestState.success,
          imageButtonText: AppStrings.addAnImage,
          imageState: ImageState.noImage,
          thereIsImage: false,
        ),
      );
      nameController.text = "";
      priceController.text = "";
      //categoryController.text = "";
      locationController.text = "";
      descriptionController.text = "";
      print("< ________ imagePath is ________ ${state.imagePath} ________ >");
      print(
          "< ________ productState is ________ ${state.productState} ________ >");
    });
  }

  Future<void> _imagePart() async {
    print(
        "< -------------------------------------------_imagePart----------------------------------------------- >");
    final uploadImageResult =
        await uploadProductImageUseCase(File(state.imagePath!));

    ///< ------------------------------------------------------------------- >

    uploadImageResult.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
                uploadImageState: RequestState.error,
                productState: RequestState.error,
              ),
            ), (imageReference) async {
      emit(state.copyWith(
        uploadImageState: RequestState.success,
      ));
      print(
          "< ________ uploadImageState is ________ ${state.uploadImageState} ________ >");

      /// < ---------------------------------------------------------------- >
      _downloadUrlPart(imageReference);
    });
  }

  Future<void> _downloadUrlPart(Reference imageReference) async {
    print(
        "< -------------------------------------------_downloadUrlPart----------------------------------------------- >");

    /// < -------------------------------------------------------------------- >
    final downloadUrlResult =
        await downloadProductImageUrlUseCase(imageReference);

    /// < ------------------------------------------------------------------- >
    downloadUrlResult.fold(
        (l) => emit(
              state.copyWith(
                errorMessage: l.message,
                downloadImageState: RequestState.error,
                productState: RequestState.error,
              ),
            ), (imageUrl) async {
      emit(state.copyWith(downloadImageState: RequestState.success));
      print(
          "< ________ downloadImageState is ________ ${state.downloadImageState} ________ >");
      if (state.addUpdateButtonText == AppStrings.update) {
        await _upDateProduct(
          productImage: imageUrl,
        );
      } else {
        await _addProduct(imageUrl);
      }
    });
  }

  Future<void> getImageFromGallery() async {
    print(
        "< -------------------------------------------getImageFromGallery----------------------------------------------- >");
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

/*  late String productName;
  late String productPrice;
  late String productLocation;
  late String productCategory;
  late String productDescription;*/

/*Future<void> testing() async {
    if(formKey.currentState!.validate()){    /// < -------------------------------------------------------------------- >
      final addProductResult = await addProductUseCase(
        AddProductParameters(
          productDescription: descriptionController.text,
          productCategory: categoryController.text,
          productLocation: locationController.text,
          productPrice: priceController.text,
          productName: nameController.text,
          productImage: "imageUrl",
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
            productState: RequestState.success,
            imageButtonText: AppStrings.addAnImage,
            thereIsImage: false,
          ),
        );
        nameController.text = "";
        priceController.text = "";
        categoryController.text = "";
        locationController.text = "";
        descriptionController.text = "";
        print("< ________ imagePath is ________ ${state.imagePath} ________ >");
        print(
            "< ________ productState is ________ ${state.productState} ________ >");
      });}
  }*/
