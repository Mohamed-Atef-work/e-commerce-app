import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_button.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_text.dart';
import '../../../../core/components/product_component.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/screens_strings.dart';
import '../controllers/product_details_controller/product_details_cubit.dart';
import '../widgets/product_image_widget.dart';

class ProductsOfCategoryScreen extends StatelessWidget {
  const ProductsOfCategoryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /*const ProductEntity product = ProductEntity(
      description: "we are testing",
      location: "home",
      category: "jackets",
      price: "100",
      image:
          "https://firebasestorage.googleapis.com/v0/b/ecommerce-39620.appspot.com/o/productImagesIMG-20231030-WA0011.jpg?alt=media&token=ddccf23c-2e3b-420b-a0a4-5cc527aff36b",
      name: "Product details Screen task",
      id: "",
    );*/
    final ProductEntity product =
        ModalRoute.of(context)!.settings.arguments as ProductEntity;

    return BlocProvider<ProductDetailsCubit>(
      create: (context) => sl<ProductDetailsCubit>()
        ..emitProduct(product)
        ..loadProducts(product.category),
      child: Builder(builder: (context) {
        ///
        final controller = BlocProvider.of<ProductDetailsCubit>(context);

        ///
        return Scaffold(
          backgroundColor: AppColors.primaryColorYellow,
          appBar: appBar(title: AppStrings.products),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: [
              BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                buildWhen: (previous, current) =>
                    previous.selectedProduct != current.selectedProduct,
                builder: (context, state) {
                  /// Inside this ---> implement [Fav] .........
                  return ProductDetailsImageWidget(
                    product: state.selectedProduct!,
                  );
                },
              ),
              SizedBox(height: context.height * 0.01),
              CustomText(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                text: controller.state.selectedProduct!.category,
              ),
              SizedBox(height: context.height * 0.01),
              _products(),
              CustomButton(
                width: 0,
                height: 45,
                text: AppStrings.details,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Screens.detailsScreen,
                    arguments: BlocProvider.of<ProductDetailsCubit>(context)
                        .state
                        .selectedProduct,
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _products() => SizedBox(
        height: 200,
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          buildWhen: (previous, current) =>
              previous.productsState != current.productsState,
          builder: (context, state) {
            if (state.productsState == RequestState.success) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: state.products!.length,
                itemBuilder: (context, index) => ProductComponent(
                  onTap: () {
                    BlocProvider.of<ProductDetailsCubit>(context)
                        .emitSelectedProduct(index);
                  },
                  name: state.products![index].name,
                  image: state.products![index].image,
                ),
              );
            } else {
              return const LoadingWidget();
            }
          },
        ),
      );
}