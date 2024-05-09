import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/modules/admin/presentation/widgets/add_category_model_sheet_widget.dart';
import 'package:flutter/material.dart';

class AddCategoryWidget extends StatelessWidget {
  const AddCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      child: IconButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => const AddNewCategoryModelSheetWidget());
        },
        splashRadius: 25,
//hoverColor: Colors.transparent,
        highlightColor: kWhiteGray,
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
