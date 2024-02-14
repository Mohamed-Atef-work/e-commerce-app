import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/modules/admin/domain/entities/product_entity.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/add_product_form.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/add_product_buttons.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/manage_product_local_image_widget.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_cubit.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, ProductEntity>? arguments;
    if (ModalRoute.of(context)?.settings.arguments != null) {
      arguments = ModalRoute.of(context)?.settings.arguments
          as Map<String, ProductEntity>;
    }

    return BlocProvider(
      create: (context) => sl<EditAddProductCubit>()
        ..getCategories()
        ..decideAddOrUpdate(arguments?["product"]),
      child: Scaffold(
        backgroundColor: kPrimaryColorYellow,
        appBar: appBar(title: AppStrings.admin),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
              left: context.width * 0.01,
              right: context.width * 0.01,
              bottom: context.height * 0.02),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: context.height * 0.01),
              child: const ManageProductImageWidget(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.height * 0.01,
                horizontal: 15,
              ),
              child: const CustomText(
                text: AppStrings.categories,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const AddProductFormWidget(),
            const AddProductButtons(),
          ],
        ),
      ),
    );
  }
}
