import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/services/fire_store_services/cart.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/favorite_product_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/utils/screens_strings.dart';
import '../../../admin/data/model/product_model.dart';
import '../../../admin/domain/entities/product_entity.dart';
import '../widgets/cart_product_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = CartStoreImpl(FirebaseFirestore.instance);
    return Scaffold(
      backgroundColor: AppColors.primaryColorYellow,
      appBar: appBar(title: AppStrings.cart),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: store.getCartProducts("uId"),
                builder: (context, snapShot) {
                  if (snapShot.hasData) {
                    final data = snapShot.data
                        as List<DocumentSnapshot<Map<String, dynamic>>>;
                    final List<ProductEntity> pros = List<ProductModel>.of(data
                        .map((e) => ProductModel.formJson(
                              json: e.data()!,
                              productId: e.id,
                            ))
                        .toList());

                    return ListView.builder(
                      itemCount: pros.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => CartProductWidget(
                        onPressed: () {
                          Navigator.pushNamed(context, Screens.detailsScreen,
                              arguments: pros[index]);
                        },
                        product: pros[index],
                      ),
                    );
                  } else {
                    return const LoadingWidget();
                  }
                }),
          ),
          OutlinedButton(
            onPressed: () {},
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
            child: const CustomText(
              fontSize: 20,
              text: AppStrings.order,
              textColor: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.pacifico,
            ),
          ),
        ],
      ),
    );
  }
}
