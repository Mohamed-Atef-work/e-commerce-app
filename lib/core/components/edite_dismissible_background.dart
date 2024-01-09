import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class EditeDismissibleBackgroundComponent extends StatelessWidget {
  const EditeDismissibleBackgroundComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(5),
      padding: EdgeInsets.only(right: context.width * 0.15),
      child: const Icon(Icons.edit),
    );
  }
}
