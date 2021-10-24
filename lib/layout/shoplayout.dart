import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/shop_cubit.dart';
import 'package:shop/layout/cubit/shop_states.dart';
import 'package:shop/modules/search/search_screen.dart';
import 'package:shop/shared/styles/colors.dart';

class HomeLayout extends StatelessWidget {
  static const String id='HomeLayout';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener:(context,state){} ,
      builder: (context,state){
        var bottomNavBarCubit = ShopCubit.get(context);
        return Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: bottomNavBarCubit.pagecontroller,
            children: bottomNavBarCubit.PageViews,
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            items: [
              CustomBottomNavigationBarItem(
                icon: Icons.home,
                title: 'Home',
              ),
              CustomBottomNavigationBarItem(
                icon: Icons.apps,
                title: 'Cateogries',
              ),
              CustomBottomNavigationBarItem(
                icon: Icons.favorite,
                title: 'Favorites',
              ),
              CustomBottomNavigationBarItem(
                icon: Icons.settings,
                title: 'Setting',
              ),
            ],
            onTap: (index)
            {
              bottomNavBarCubit.ChangeBottomNavBar(index);
            },
              backgroundColor: defaultColor[300],
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black54,
             itemBackgroudnColor: defaultColor,

          ),
        );
      },
    );
  }
}
