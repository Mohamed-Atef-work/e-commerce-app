import 'package:e_commerce_app/modules/admin/presentation/widgets/add_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/loading_widget.dart';
import '../../../../core/components/product_category_component.dart';
import '../../../../core/utils/enums.dart';
import '../controllers/add_product_controller/add_product_cubit.dart';
import '../controllers/add_product_controller/add_product_state.dart';

class ProductCategoriesWidget extends StatelessWidget {
  const ProductCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: 45,
      child: BlocBuilder<EditAddProductCubit, EditAddProductState>(
        builder: (context, state) {
          if (state.getCategoriesState == RequestState.loading) {
            return const LoadingWidget();
          } else {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: state.categories!.length + 1,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => index == state.categories!.length
                  ? const AddCategoryWidget()
                  : CategoryComponent(
                      onTap: () {
                        BlocProvider.of<EditAddProductCubit>(context)
                            .categoryIndex(index);
                      },
                      category: state.categories![index],
                      backgroundColor: state.categoryIndex == index
                          ? Colors.grey.shade200
                          : Colors.black,
                      iconAndTextColor: state.categoryIndex == index
                          ? Colors.black
                          : Colors.white,
                    ),
              separatorBuilder: (context, index) =>
                  SizedBox(width: width * 0.01),
            );
          }
        },
      ),
    );
  }
}
