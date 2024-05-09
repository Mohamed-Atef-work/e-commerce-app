import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/user/presentation/widgets/heart_with_manage_favorite_cubit_provided_widget.dart';
import 'package:flutter/material.dart';

class ProductDetailsImageWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsImageWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            width: context.width / 1.3,
            height: context.height / 2.3,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Image.network(
              product.image,
              fit: BoxFit.fill,
              height: context.height / 4,
            ),
          ),
          HeartWihMangeFavoriteCubitProviderWidget(
            heartColor: Colors.white,
            product: product,
          ),
        ],
      ),
    );
  }
}

class ProductOfCategoryImageWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductOfCategoryImageWidget(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: context.width / 1.3,
        height: context.height / 2.3,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Image.network(
          product.image,
          fit: BoxFit.fill,
          height: context.height / 4,
        ),
      ),
    );
  }
}
