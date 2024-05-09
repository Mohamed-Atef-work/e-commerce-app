import 'package:e_commerce_app/modules/shared/presentation/controllers/products_view_controller/products_view_cubit.dart';
import 'package:e_commerce_app/modules/shared/presentation/widgets/loading_home_data_widget.dart';
import 'package:e_commerce_app/core/components/product_category_component.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        top: 5,
        bottom: 5,
      ),
      child: SizedBox(
        height: context.height * 0.065,
        child: BlocBuilder<ProductsViewCubit, ProductsViewState>(
          builder: (context, state) {
            if (state.categoriesState == RequestState.loading) {
              return const LoadingCategoriesWidget();
            } else {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => CategoryComponent(
                  onTap: () {
                    BlocProvider.of<ProductsViewCubit>(context)
                        .emitCategoryIndex(index);
                    print(state.categories[index].id);
                  },
                  category: state.categories[index],
                  backgroundColor: state.categoryIndex == index
                      ? Colors.grey.shade200
                      : Colors.black,
                  iconAndTextColor: state.categoryIndex == index
                      ? Colors.black
                      : Colors.white,
                ),
                separatorBuilder: (context, index) =>
                    SizedBox(width: context.width * 0.01),
              );
            }
          },
        ),
      ),
    );
  }
}
