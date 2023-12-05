import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/app_bar.dart';
import '../../../../core/components/custom_button.dart';
import '../../../../core/components/custom_text.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/screens_strings.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/delete_product_use_case.dart';
import '../controllers/admin_product_details_controller/admin_product_details_cubit.dart';
import '../controllers/admin_product_details_controller/admin_product_details_state.dart';
import '../widgets/admin_details_screen_products_widget.dart';

class AdminProductDetailsScreen extends StatelessWidget {
  const AdminProductDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ///
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    final ProductEntity product =
        ModalRoute.of(context)?.settings.arguments as ProductEntity;
    print(product.id);

    ///
    return BlocProvider<AdminProductDetailsCubit>(
      create: (context) => sl<AdminProductDetailsCubit>()
        ..emitProduct(product)
        ..loadProducts(product.category),
      child: Builder(builder: (context) {
        ///
        final controller = BlocProvider.of<AdminProductDetailsCubit>(context);

        ///
        return Scaffold(
          backgroundColor: AppColors.primaryColorYellow,
          appBar: appBar(
            title: AppStrings.productDetails,
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            physics: const BouncingScrollPhysics(),
            children: [
              BlocBuilder<AdminProductDetailsCubit, AdminProductDetailsState>(
                buildWhen: (previous, current) =>
                    previous.selectedProduct != current.selectedProduct,
                builder: (context, state) {
                  return SizedBox(
                    width: width,
                    height: height / 2.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: width / 1.3,
                              height: height / 2.3,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: state.selectedProduct?.image == null
                                  ? Image.asset(
                                      "assets/images/icons/login_buy_icon.png",
                                      fit: BoxFit.cover,
                                      height: height / 4,
                                    )
                                  : Image.network(
                                      state.selectedProduct!.image,
                                      fit: BoxFit.fill,
                                      height: height / 4,
                                    ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Screens.addProductScreen,
                                      arguments: {"product": product},
                                    );
                                  },
                                  child: const Icon(Icons.edit,
                                      color: Colors.green),
                                ),
                                TextButton(
                                  onPressed: () {
                                    BlocProvider.of<AdminProductDetailsCubit>(
                                            context)
                                        .deleteProduct(
                                      DeleteProductParameters(
                                        product.id,
                                        product.category,
                                      ),
                                    );
                                  },
                                  child: const CustomText(
                                    text: AppStrings.delete,
                                    textColor: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: height * 0.01),
              CustomText(
                fontSize: 23,
                text: controller.state.selectedProduct!.category,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: height * 0.01),
              const AdminProductsWidget(),
              CustomButton(
                onPressed: () {
                  /// Navigate To Details
                  Navigator.pushNamed(context, Screens.detailsScreen,arguments: product);
                },
                width: 0,
                height: 45,
                text: AppStrings.productDetails,
              ),
            ],
          ),
        );
      }),
    );
  }

}
