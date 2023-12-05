import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/product_image_widget.dart';
import 'package:flutter/material.dart';

class ProductDetailsWidget extends StatelessWidget {
  final ProductEntity product;
  const ProductDetailsWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange.shade300,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProductDetailsImageWidget(product: product),
          _oneItem(field: AppStrings.productName, value: product.name),
          _oneItem(field: AppStrings.productCategory, value: product.category),
          _oneItem(
              field: AppStrings.productDescription, value: product.description),
          _oneItem(field: AppStrings.productPrice, value: product.price),
          _oneItem(field: AppStrings.productLocation, value: product.location),
        ],
      ),
    );
  }

  Widget _oneItem({
    required String field,
    required String value,
  }) =>
      Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          CustomText(
            text: "$field :",
            fontSize: 18,
            fontWeight: FontWeight.w600,
            textColor: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: CustomText(
              text: value,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textColor: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 10,
            color: Colors.black,
            thickness: .5,
            endIndent: 60,
            indent: 60,
          ),
        ],
      );
}
