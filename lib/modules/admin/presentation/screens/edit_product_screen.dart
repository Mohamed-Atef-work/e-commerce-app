import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:e_commerce_app/core/utils/enums.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/config/service_locator/sl.dart';
import 'package:e_commerce_app/core/constants/widgets/show_toast.dart';
import 'package:e_commerce_app/core/components/messenger_component.dart';
import 'package:e_commerce_app/core/fire_base/fire_store/store_helper.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/add_product_form.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/add_product_buttons.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/manage_edit_product_image_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/edit_product_controller/edit_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/edit_product_controller/edit_product_state.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_details_controller/admin_details_cubit.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    final ProductEntity product;
    product = ModalRoute.of(context)!.settings.arguments as ProductEntity;

    return BlocProvider(
      create: (_) => sl<EditProductCubit>()
        ..getCategories()
        ..init(product),
      child: Scaffold(
        backgroundColor: kPrimaryColorYellow,
        appBar: appBar(title: AppStrings.admin),
        body: BlocConsumer<EditProductCubit, EditProductState>(
          listener: _listener,
          builder: (_, state) {
            if (state.getCategoriesState == RequestState.loading) {
              return const MessengerComponent("Loading");
            } else if (state.productState == RequestState.error ||
                state.getCategoriesState == RequestState.error) {
              return MessengerComponent(state.errorMessage!);
            } else if (state.productState == RequestState.success) {
              return const MessengerComponent(AppStrings.updated);
            }
            return ListView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  left: width * 0.01,
                  right: width * 0.01,
                  bottom: height * 0.02),
              children: [
                const ManageProductImageWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.01,
                    horizontal: 15,
                  ),
                  child: const CustomText(
                    text: AppStrings.categories,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const EditProductFormWidget(),
                const EditProductButtons(),
              ],
            );
          },
        ),
      ),
    );
  }

  void _listener(BuildContext context, EditProductState state) {
    if (state.productState == RequestState.success) {
      final params = GetProductParams(
        productId: state.productId!,
        category: state.categories![state.categoryIndex!].name,
      );
      final controller = BlocProvider.of<AdminDetailsCubit>(context);
      controller.getProduct(params);
    } else if (state.productState == RequestState.error) {
      showMyToast(state.errorMessage!, context, Colors.red);
    }
    if (state.getCategoriesState == RequestState.success) {
      final controller = BlocProvider.of<EditProductCubit>(context);
      controller.setCategory();
    }
  }
}
