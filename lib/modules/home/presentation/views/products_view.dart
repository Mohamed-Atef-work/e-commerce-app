import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/utils/screens_strings.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/core/components/product_details_component.dart';
import 'package:e_commerce_app/modules/home/presentation/widgets/categories_widget.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/loading_home_data_widget.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/product_details_controller/product_details_cubit.dart';

class UserProductsView extends StatelessWidget {
  const UserProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CategoriesWidget(),
        Expanded(
          child: BlocBuilder<ProductsViewCubit, ProductsViewState>(
            builder: (context, state) {
              if (state.categoriesState != RequestState.success ||
                  state.productsState != RequestState.success) {
                return const LoadingHomeProductsWidget();
              } else if (state.products.isEmpty) {
                return const MessengerComponent(
                    mess: AppStrings.thereIsNoProducts);
              } else {
                return GridView.builder(
                  itemCount: state.products.length,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * 0.02),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: context.height * 0.005,
                    crossAxisSpacing: context.width * 0.01,
                    childAspectRatio: 1 / 1.6,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) => ProductComponent(
                    onPressed: () {
                      BlocProvider.of<ProductDetailsCubit>(context)
                          .product(state.products[index]);
                      Navigator.pushNamed(context, Screens.detailsScreen);
                    },
                    product: state.products[index],
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
