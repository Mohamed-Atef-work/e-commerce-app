import 'package:e_commerce_app/core/components/app_bar.dart';
import 'package:e_commerce_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: AppStrings.order),
      body: const Column(children: []),
    );
  }
}
