import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/components/custom_text.dart';
import 'package:e_commerce_app/core/services/service_locator/sl.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/add_product_form.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/add_product_buttons.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/add_product_controller/add_product_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/manage_add_product_image_widget.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AddProductCubit>()..getCategories(),
      child: Scaffold(
        backgroundColor: kPrimaryColorYellow,
        appBar: appBar(title: AppStrings.admin),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            left: context.width * 0.01,
            right: context.width * 0.01,
            bottom: context.height * 0.02,
          ),
          children: [
            const ManageAddProductImageWidget(),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.height * 0.01,
                horizontal: 15,
              ),
              child: const CustomText(
                fontSize: 20,
                text: AppStrings.categories,
                fontWeight: FontWeight.bold,
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
