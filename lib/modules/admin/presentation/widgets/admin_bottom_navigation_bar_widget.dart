import 'package:e_commerce_app/core/constants/colors.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_layout_controller/admin_layout_cubit.dart';
import 'package:e_commerce_app/modules/admin/presentation/controllers/admin_layout_controller/admin_layout_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminBottomNavigationBarWidget extends StatelessWidget {
  const AdminBottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminLayoutCubit, AdminLayoutState>(
      builder: (context, state) {
        return BottomNavigationBar(
          //unselectedItemColor: Colors.orange,
          type: BottomNavigationBarType.fixed,
          fixedColor: kPrimaryColorYellow,
          backgroundColor: kPrimaryColorYellow,
          onTap: (index) {
            BlocProvider.of<AdminLayoutCubit>(context).newView(index);
          },
          currentIndex:
          BlocProvider
              .of<AdminLayoutCubit>(context)
              .state
              .currentIndex,
          items: const [
            BottomNavigationBarItem(
              label: '',
              activeIcon: Icon(Icons.home, color: Colors.white),
              icon: Icon(Icons.home, color: Colors.black),
            ),
            BottomNavigationBarItem(
              label: '',
              activeIcon: Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Icon(Icons.shopping_basket, color: Colors.white),
              ),
              icon: Padding(
                padding: EdgeInsets.only(right: 5.0),
                child: Icon(Icons.shopping_basket, color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              activeIcon: Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(Icons.favorite, color: Colors.white),
              ),
              icon: Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Icon(Icons.favorite, color: Colors.black),
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              activeIcon: Icon(Icons.person_rounded, color: Colors.white),
              icon: Icon(Icons.person_rounded, color: Colors.black),
            ),
          ],
        );
      },
    );
  }
}
