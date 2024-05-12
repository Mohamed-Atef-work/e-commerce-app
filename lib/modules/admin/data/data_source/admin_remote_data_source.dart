import 'package:e_commerce_app/core/fire_base/fire_store/product.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_category_model.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import '../../domain/entities/product_category_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/params/add_new_product_category_params.dart';
import '../../domain/params/delete_product_category_params.dart';
import '../../domain/params/delete_product_params.dart';
import '../../domain/params/edit_product_params.dart';
import '../../../shared/domain/use_cases/load_product_params.dart';
import '../../domain/params/up_date_product_category_params.dart';

abstract class AdminBaseRemoteDataSource {
  Future<void> addProduct(AddProductParams params);
  Future<void> deleteProduct(DeleteProductParams params);
  Future<void> updateProduct(UpdateProductParams params);
  Stream<List<ProductCategoryEntity>> getAllProductCategories();
  Stream<List<ProductEntity>> loadProducts(LoadProductsParams params);
  Future<void> addNewProductCategory(AddNewProductsCategoryParams params);
  Future<void> deleteProductCategory(DeleteProductsCategoryParams params);
  Future<void> upDateProductCategory(UpDateProductsCategoryParams params);
}

class AdminRemoteDataSourceImpl implements AdminBaseRemoteDataSource {
  final ProductStore store;

  AdminRemoteDataSourceImpl(this.store);

  @override
  Future<void> addProduct(AddProductParams params) async {
    return await store.addProduct(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Stream<List<ProductEntity>> loadProducts(LoadProductsParams params) {
    final streamOfSnaps = store.loadProducts(params);
    final streamOfModels = streamOfSnaps.map(
      (snapshot) {
        return snapshot.docs
            .map(
              (doc) => ProductModel.formJson(
                json: doc.data(),
                productId: doc.id,
              ),
            )
            .toList();
      },
    );
    return streamOfModels;
  }

  @override
  Future<void> deleteProduct(DeleteProductParams params) async {
    await store.deleteProduct(params).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> updateProduct(UpdateProductParams params) async {
    await store.updateProduct(params).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> addNewProductCategory(
      AddNewProductsCategoryParams params) async {
    await store.addNewProductCategory(params).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Stream<List<ProductCategoryEntity>> getAllProductCategories() {
    final stream = store.getAllProductCategories();
    return stream.map((snapShot) {
      return snapShot.docs
          .map((category) => ProductCategoryModel.fromJson(
                category.data(),
                id: category.id,
              ))
          .toList();
    });
  }

  @override
  Future<void> deleteProductCategory(
      DeleteProductsCategoryParams params) async {
    await store.deleteProductCategory(params).catchError((error) {
      throw ServerException(message: error.code);
    });
  }

  @override
  Future<void> upDateProductCategory(
      UpDateProductsCategoryParams params) async {
    await store.upDateProductCategory(params).catchError((error) {
      throw ServerException(message: error.code);
    });
  }
}
