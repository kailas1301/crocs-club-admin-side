import 'package:crocsclub_admin/application/business_logic/nav_bar/bloc/navbar_bloc.dart';
import 'package:crocsclub_admin/application/presentation/add_category/add_category.dart';
import 'package:crocsclub_admin/application/presentation/admin_home_screen/admin_home_scrn.dart';
import 'package:crocsclub_admin/application/presentation/offers_and_coupons/offers_coupons_add.dart';
import 'package:crocsclub_admin/application/presentation/users_screen/users_screen.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
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
          } else if (state is AddCategorySelected) {
            currentScreen = const AddCategoryScrn();
          } else if (state is OffersCouponsSelected) {
            currentScreen = const OffersAndCouponsAddingScreen();
          } else if (state is UserSelected) {
            currentScreen = const UsersScreen();
          }

          return Scaffold(
            body: currentScreen, // Set body based on state
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GNav(
                color: kDarkGreyColour,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                gap: 6,
                activeColor: kwhiteColour,
                iconSize: 20,
                textSize: 9,
                tabBackgroundColor: kAppPrimaryColor,
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 250),
                tabs: [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                    textStyle:
                        const TextStyle(fontSize: 15, color: kwhiteColour),
                    onPressed: () =>
                        context.read<NavbarBloc>().add(HomePressed()),
                  ),
                  GButton(
                    icon: Icons.new_label,
                    text: 'Add Product',
                    textStyle:
                        const TextStyle(fontSize: 16, color: kwhiteColour),
                    onPressed: () =>
                        context.read<NavbarBloc>().add(AddProductPressed()),
                  ),
                  GButton(
                    icon: Icons.local_offer,
                    text: 'Add deals',
                    textStyle:
                        const TextStyle(fontSize: 16, color: kwhiteColour),
                    onPressed: () =>
                        context.read<NavbarBloc>().add(OffersCouponsPressed()),
                  ),
                  GButton(
                    icon: Icons.people,
                    text: 'Users',
                    textStyle:
                        const TextStyle(fontSize: 16, color: kwhiteColour),
                    onPressed: () =>
                        context.read<NavbarBloc>().add(UserPressed()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
