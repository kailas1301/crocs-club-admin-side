import 'package:crocsclub_admin/business_logic/nav_bar/bloc/navbar_bloc.dart';
import 'package:crocsclub_admin/presentation/add_product/add_products.dart';
import 'package:crocsclub_admin/presentation/admin_home_screen/admin_home_scrn.dart';
import 'package:crocsclub_admin/presentation/offers_and_coupons/offers_coupons_add.dart';
import 'package:crocsclub_admin/presentation/users_screen/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavbarBloc>(
      // Wrap with BlocProvider
      create: (context) => NavbarBloc(),
      child: BlocBuilder<NavbarBloc, NavbarState>(
        builder: (context, state) {
          Widget currentScreen = const AdminHome(); // Default screen

          if (state is HomeSelected) {
            currentScreen = const AdminHome();
          } else if (state is AddProductSelected) {
            currentScreen = const AddProductingScrn();
          } else if (state is OffersCouponsSelected) {
            currentScreen = const OffersAndCouponsAddingScreen();
          } else if (state is UserSelected) {
            currentScreen = const UsersScreen();
          }

          return Scaffold(
            body: currentScreen, // Set body based on state
            bottomNavigationBar: GNav(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              gap: 8,
              activeColor: Colors.blue,
              iconSize: 24,
              tabBackgroundColor: Colors.grey,
              duration: const Duration(milliseconds: 250),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPressed: () =>
                      context.read<NavbarBloc>().add(HomePressed()),
                ),
                GButton(
                  icon: Icons.plus_one,
                  text: 'Add Product',
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPressed: () =>
                      context.read<NavbarBloc>().add(AddProductPressed()),
                ),
                GButton(
                  icon: Icons.attach_money,
                  text: 'Coupons and Offers',
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPressed: () =>
                      context.read<NavbarBloc>().add(OffersCouponsPressed()),
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Users',
                  textStyle: const TextStyle(fontSize: 16, color: Colors.white),
                  onPressed: () =>
                      context.read<NavbarBloc>().add(UserPressed()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
