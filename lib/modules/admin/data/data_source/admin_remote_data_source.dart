import 'package:e_commerce_app/core/fire_base/fire_store/product.dart';
import 'package:e_commerce_app/core/error/exceptions.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/domain/use_cases/add_product_use_case.dart';
import '../../domain/params/add_new_product_category_params.dart';
import '../../domain/params/delete_product_category_params.dart';
import '../../domain/params/delete_product_params.dart';
import '../../domain/use_cases/update_product_without_new_image_use_case.dart';
import '../../domain/params/up_date_product_category_params.dart';

abstract class AdminBaseRemoteDataSource {
  Future<String> addProduct(ProductModelParams params);
  Future<void> deleteProduct(DeleteProductParams params);
  Future<void> updateProduct(UpdateProductParams params);
  Future<ProductEntity> getProduct(GetProductParams params);
  Future<void> addNewProductCategory(AddNewProductsCategoryParams params);
  Future<void> deleteProductCategory(DeleteProductsCategoryParams params);
  Future<void> upDateProductCategory(UpDateProductsCategoryParams params);
}

class AdminRemoteDataSourceImpl implements AdminBaseRemoteDataSource {
  final ProductStore _store;
  final StoreHelper _storeHelper;

  AdminRemoteDataSourceImpl(this._store, this._storeHelper);

  @override
  Future<String> addProduct(ProductModelParams params) async {
    return await _store.addProduct(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<void> deleteProduct(DeleteProductParams params) async {
    try {
      await _store.deleteProduct(params);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> updateProduct(UpdateProductParams params) async {
    try {
      await _store.updateProduct(params);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> addNewProductCategory(
      AddNewProductsCategoryParams params) async {
    await _store.addNewProductCategory(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<void> deleteProductCategory(
      DeleteProductsCategoryParams params) async {
    await _store.deleteProductCategory(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<void> upDateProductCategory(
      UpDateProductsCategoryParams params) async {
    await _store.upDateProductCategory(params).catchError((error) {
      throw ServerException(message: error.toString());
    });
  }

  @override
  Future<ProductEntity> getProduct(GetProductParams params) async {
    try {
      final result = await _storeHelper.getProduct(params);
      final product =
          ProductModel.formJson(json: result.data()!, productId: result.id);
      return product;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
