import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utils/extensions.dart';

class DismissibleBackgroundComponent extends StatelessWidget {
  final Color color;
  final IconData icon;

  const DismissibleBackgroundComponent({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.only(left: context.width * 0.15),
      //margin: const EdgeInsets.all(5),
      child: Icon(icon),
    );
  }
}

class DismissibleSecondaryBackgroundComponent extends StatelessWidget {
  final Color color;
  final IconData icon;

  const DismissibleSecondaryBackgroundComponent({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.only(right: context.width * 0.15),
      //margin: const EdgeInsets.all(5),
      child: Icon(icon),
    );
  }
}
