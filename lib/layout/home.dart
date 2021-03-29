import 'package:e_commerce/layout/cubit/cubit.dart';
import 'package:e_commerce/layout/cubit/states.dart';
import 'package:e_commerce/modules/cart/cart_screen.dart';
import 'package:e_commerce/modules/dashboard/dashboard.dart';
import 'package:e_commerce/modules/favorite/favorite.dart';
import 'package:e_commerce/modules/profile/profile_screen.dart';
import 'package:e_commerce/modules/settings/setting_screen.dart';
import 'package:e_commerce/shared/commponents/commponents.dart';
import 'package:e_commerce/shared/network/local/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  List screens = [
    DashboardScreen(),
    FavoriteScreen(),
    CartScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (BuildContext context) => HomeScreenCubit(),
      child: BlocConsumer<HomeScreenCubit, HomeScreenStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          currentIndex = HomeScreenCubit.get(context).currentIndex;
          return Scaffold(
            backgroundColor: kScaffoldColor,
            // appBar: AppBar(
            //   backgroundColor: kScaffoldColor,
            //   elevation: 0.0,
            //   actions: [
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(Icons.notifications_none_outlined , color: Colors.grey[700],),
            //     ),
            //
            //   ],
            // ),
            body: screens[currentIndex],
            bottomNavigationBar: Container(
              width: double.infinity,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, -15),
                    blurRadius: 20,
                    color: Color(0xFFDADADA).withOpacity(0.15),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: SafeArea(
                top: false,
                child: BottomNavigationBar(
                  elevation: 0.0,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(
                      Icons.home_outlined,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_outline), label: 'Favorite'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline), label: 'Profile'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: 'Settings'),
                  ],
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  selectedItemColor: kPrimaryColor,
                  currentIndex: currentIndex,
                  onTap: (value) {
                    HomeScreenCubit.get(context).changeIndex(value);
                  },
                  backgroundColor: Colors.white,
                  selectedFontSize: getProportionateScreenWidth(8.0),
                  unselectedFontSize: getProportionateScreenWidth(8.0),
                  iconSize: getProportionateScreenWidth(20.0),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
