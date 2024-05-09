import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/user_layout_controller/user_layout_cubit.dart';
import 'package:e_commerce_app/modules/home/presentation/controllers/user_layout_controller/user_layout_states.dart';

class UserBottomNavigationBarWidget extends StatelessWidget {
  const UserBottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLayoutCubit, UserLayoutState>(
        builder: (context, state) {
      return BottomNavigationBar(
        unselectedItemColor: Colors.orange,
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimaryColorYellow,
        onTap: (index) {
          BlocProvider.of<UserLayoutCubit>(context).newScreen(index);
        },
        currentIndex:
            BlocProvider.of<UserLayoutCubit>(context).state.currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.shopping_cart, color: Colors.white),
            icon: Icon(Icons.shopping_cart, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.favorite, color: Colors.white),
            icon: Icon(Icons.favorite, color: Colors.black),
          ),
          BottomNavigationBarItem(
            label: '',
            activeIcon: Icon(Icons.person_rounded, color: Colors.white),
            icon: Icon(Icons.person_rounded, color: Colors.black),
          ),
        ],
      );
    });
  }
}
