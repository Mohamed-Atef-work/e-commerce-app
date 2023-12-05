import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';

class ProductComponent extends StatelessWidget {
  final void Function() onTap;
  final String? image;
  final String name;
  const ProductComponent({
    super.key,
    required this.onTap,
    required this.image,
    required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 150,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: image != null
                ? Image.network(
                    image!,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    "https://i.pinimg.com/originals/49/e5/8d/49e58d5922019b8ec4642a2e2b9291c2.png",
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(
            height: 12,
          ),
          CustomText(
            text: name,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            fontSize: 15,
          ),
        ],
      ),
    );
  }
}
