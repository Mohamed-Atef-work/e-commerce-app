import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/product_details_component.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/categories_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../admin/domain/entities/product_entity.dart';

class HomeLayoutScreen extends StatelessWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocProvider<HomeCubit>(
      create: (context) => sl<HomeCubit>()
        ..loadCategories()
        ..loadProductsOfTheFirstCategory(),
      child: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.primaryColorYellow,
          centerTitle: true,
          title: const CustomText(
            text: AppStrings.categories,
            fontSize: 30,
            fontFamily: AppStrings.pacifico,
            fontWeight: FontWeight.bold,
            textColor: AppColors.black,
          ),
        ),
        body: Column(
          children: [
            const CategoriesWidget(),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state.categoriesState != RequestState.success ||
                      state.productsState != RequestState.success) {
                    return const LoadingWidget();
                  } else if (state.products.isEmpty) {
                    return const Center(
                      child: CustomText(text: "No Data"),
                    );
                  } else {
                    return GridView.builder(
                      itemCount: state.products.length,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.6,
                        crossAxisSpacing: width * 0.01,
                        mainAxisSpacing: height * 0.005,
                      ),
                      itemBuilder: (context, index) =>
                          ProductWithMoreDetailsComponent(
                        product: state.products[index],
                        imageWidth: width * 0.48,
                        imageHeight: height * 0.25,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigationBarWidget(),
      ),
    );
  }
}

final List<String> _tabs = [
  AppStrings.jackets,
  AppStrings.shirts,
  AppStrings.suits,
];

final List<ProductEntity> _products = List.generate(
  10,
  (index) => const ProductEntity(
    description: "we are testing",
    location: "home",
    category: "jackets",
    price: "100",
    image:
        "https://firebasestorage.googleapis.com/v0/b/ecommerce-39620.appspot.com/o/productImagesIMG-20231030-WA0011.jpg?alt=media&token=ddccf23c-2e3b-420b-a0a4-5cc527aff36b",
    name: "Product details Screen task",
    id: "",
  ),
);
