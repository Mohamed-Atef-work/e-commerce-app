import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/modules/admin/data/model/product_model.dart';
import 'package:e_commerce_app/modules/orders/domain/entity/item_entity.dart';
import 'package:e_commerce_app/modules/orders/presentation/widgets/order_product_widget.dart';
import 'package:flutter/material.dart';

class UserOrderProductsScreen extends StatelessWidget {
  const UserOrderProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: AppStrings.yourOrder),
      backgroundColor: AppColors.primaryColorYellow,
      body: ListView.builder(
        itemCount: 5,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemBuilder: (context, index) => Dismissible(
          onDismissed: (_) {},
          key: ValueKey("df"),
          background: Container(
            color: Colors.red,
          ),
          child: const OrderProductWidget(
            OrderItemEntity(
              product: ProductModel(
                description: "description",
                category: "category",
                location: "location",
                image: "image",
                price: "price",
                name: "name",
              ),
              quantity: 5,
            ),
          ),
        ),
      ),
    );
  }
}
