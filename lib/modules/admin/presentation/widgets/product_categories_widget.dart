import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/components/loading_widget.dart';
import 'package:e_commerce_app/core/components/product_category_component.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/add_category_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_state.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/edit_product_controller/edit_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/edit_product_controller/edit_product_state.dart';

class AdminCategoriesWidgetOfAddProduct extends StatelessWidget {
  const AdminCategoriesWidgetOfAddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;

    final controller = BlocProvider.of<AddProductCubit>(context);

    return SizedBox(
      height: 45,
      child: BlocBuilder<AddProductCubit, AddProductState>(
        builder: (_, state) {
          if (state.getCategoriesState == RequestState.loading) {
            return const LoadingWidget();
          } else {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories!.length + 1,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) => index == state.categories!.length
                  ? const AddCategoryWidget()
                  : UserCategoryComponent(
                      category: state.categories![index],
                      onTap: () => controller.categoryIndex(index),
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
    );
  }
}

class AdminCategoriesWidgetOfEditProduct extends StatelessWidget {
  const AdminCategoriesWidgetOfEditProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final controller = BlocProvider.of<EditProductCubit>(context);
    return SizedBox(
      height: 45,
      child: BlocBuilder<EditProductCubit, EditProductState>(
        builder: (_, state) => ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: state.categories!.length + 1,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) => index == state.categories!.length
              ? const AddCategoryWidget()
              : UserCategoryComponent(
                  category: state.categories![index],
                  onTap: () => controller.categoryIndex(index),
                  backgroundColor: state.categoryIndex == index
                      ? Colors.grey.shade200
                      : Colors.black,
                  iconAndTextColor: state.categoryIndex == index
                      ? Colors.black
                      : Colors.white,
                ),
          separatorBuilder: (_, __) => SizedBox(width: width * 0.01),
        ),
      ),
    );
  }
}
