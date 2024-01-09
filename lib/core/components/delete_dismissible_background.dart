import 'package:e_commerce_app/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class DeleteDismissibleBackgroundComponent extends StatelessWidget {
  const DeleteDismissibleBackgroundComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(5),
      padding: EdgeInsets.only(left: context.width * 0.15),
      child: const Icon(Icons.delete),
    );
  }
}
