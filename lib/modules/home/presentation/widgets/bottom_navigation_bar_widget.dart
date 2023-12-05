import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/custom_text.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primaryColorYellow,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.orange,
      onTap: (index) {
        _currentIndex = index;
        setState(() {});
      },
      currentIndex: _currentIndex,
      items: const [
        BottomNavigationBarItem(
          label: '',
          activeIcon: Icon(Icons.ac_unit),
          icon: CustomText(text: 'Explore', fontWeight: FontWeight.bold),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.ac_unit),
          label: '',
          icon: CustomText(text: 'Explore', fontWeight: FontWeight.bold),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.ac_unit),
          label: '',
          icon: CustomText(text: 'Explore', fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
