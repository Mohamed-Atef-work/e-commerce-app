import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/services/fire_store_services/cart.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

import '../widgets/product_details_widget.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductEntity product =
        ModalRoute.of(context)!.settings.arguments as ProductEntity;
    return Scaffold(
      backgroundColor: AppColors.primaryColorYellow,
      appBar: appBar(title: AppStrings.order),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ProductDetailsWidget(product: product),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.black,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              fixedSize: Size(context.width, context.height * 0.08),
            ),
            onPressed: () async {
              final cartStore =
                  CartStoreServicesImpl(FirebaseFirestore.instance);
              cartStore.addToCart(CartParams(
                uId: 'uId',
                category: product.category,
                productId: product.id,
              ));
            },
            child: const CustomText(
              fontSize: 20,
              textColor: Colors.white,
              text: AppStrings.addToCart,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.pacifico,
            ),
          ),
        ],
      ),
    );
  }
}
