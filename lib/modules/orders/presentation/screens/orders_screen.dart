import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_widget.dart';
import 'package:flutter/material.dart';

class ViewUserOrdersScreen extends StatelessWidget {
  const ViewUserOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: AppStrings.order),
      backgroundColor: AppColors.primaryColorYellow,
      body: ListView.builder(
        itemCount: 1,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => OrderWidget(),
      ),
    );
  }
}
