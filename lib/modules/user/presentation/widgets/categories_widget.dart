import 'package:e_commerce_app/modules/shared/presentation/controllers/products_view_controller/products_view_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/loading_home_data_widget.dart';
import 'package:e_commerce_app/core/components/product_category_component.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AdminCategoriesWidget extends StatelessWidget {
  const AdminCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    final controller = BlocProvider.of<ProductsViewCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
      child: SizedBox(
        height: height * 0.065,
        child: BlocBuilder<ProductsViewCubit, ProductsViewState>(
          builder: (_, state) {
            if (state.categoriesState == RequestState.loading) {
              return const LoadingCategoriesWidget();
            } else {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) => AdminCategoryComponent(
                  category: state.categories[index],
                  onTap: () => controller.emitCategoryIndex(index),
                  backgroundColor: state.categoryIndex == index
                      ? Colors.grey.shade200
                      : Colors.black,
                  iconAndTextColor: state.categoryIndex == index
                      ? Colors.black
                      : Colors.white,
                ),
                separatorBuilder: (_, __) => SizedBox(width: width * 0.01),
              );
            }
          },
        ),
      ),
    );
  }
}

class UserCategoriesWidget extends StatelessWidget {
  const UserCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    final width = context.width;
    final controller = BlocProvider.of<ProductsViewCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
      child: SizedBox(
        height: height * 0.065,
        child: BlocBuilder<ProductsViewCubit, ProductsViewState>(
          builder: (_, state) {
            if (state.categoriesState == RequestState.loading) {
              return const LoadingCategoriesWidget();
            } else {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) => UserCategoryComponent(
                  category: state.categories[index],
                  onTap: () => controller.emitCategoryIndex(index),
                  backgroundColor: state.categoryIndex == index
                      ? Colors.grey.shade200
                      : Colors.black,
                  iconAndTextColor: state.categoryIndex == index
                      ? Colors.black
                      : Colors.white,
                ),
                separatorBuilder: (_, __) => SizedBox(width: width * 0.01),
              );
            }
          },
        ),
      ),
    );
  }
}
