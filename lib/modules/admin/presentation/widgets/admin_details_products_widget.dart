import 'package:e_commerce_app/core/components/product_component.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_product_details_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_product_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/loading_widget.dart';
import '../../../../core/utils/enums.dart';

class AdminProductsWidget extends StatelessWidget {
  const AdminProductsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.3,
      child: BlocBuilder<AdminDetailsCubit, AdminDetailsState>(
        buildWhen: (previous, current) =>
            previous.productsState != current.productsState ||
            previous.deleteState != current.productsState,
        builder: (context, state) {
          if (state.productsState == RequestState.success) {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemCount: state.products!.length,
              itemBuilder: (context, index) => ProductComponent(
                onTap: () {
                  BlocProvider.of<AdminDetailsCubit>(context)
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
}
