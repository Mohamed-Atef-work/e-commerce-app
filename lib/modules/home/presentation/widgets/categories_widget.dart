import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/home_screen_controller/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/loading_widget.dart';
import '../../../../core/components/product_category_component.dart';
import '../../../../core/utils/enums.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height * 0.065,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.categoriesState == RequestState.loading) {
            return const LoadingWidget();
          } else {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => CategoryComponent(
                onTap: () {
                  BlocProvider.of<HomeCubit>(context).emitCategoryIndex(index);
                  BlocProvider.of<HomeCubit>(context).loadProducts();
                  print(state.categories[index].id);
                },
                category: state.categories[index],
                backgroundColor: state.categoryIndex == index
                    ? Colors.grey.shade200
                    : Colors.black,
                iconAndTextColor:
                    state.categoryIndex == index ? Colors.black : Colors.white,
              ),
              separatorBuilder: (context, index) =>
                  SizedBox(width: context.width * 0.01),
            );
          }
        },
      ),
    );
  }
}
