import 'package:crocsclub_admin/application/business_logic/coupon/bloc/coupon_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/offer/bloc/offer_bloc.dart';
import 'package:crocsclub_admin/application/presentation/offers_and_coupons/coupon/coupons_screen.dart';
import 'package:crocsclub_admin/application/presentation/offers_and_coupons/offers/offers_screen.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersAndCouponsAddingScreen extends StatelessWidget {
  const OffersAndCouponsAddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CouponBloc>(context).add(FetchCoupons());
    BlocProvider.of<OfferBloc>(context).add(GetOffersEvent());
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const AppBarTextWidget(title: 'Offers and Coupons'),
          bottom: const TabBar(
            indicatorColor: kAppPrimaryColor,
            labelStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            labelColor: kPrimaryDarkColor,
            tabs: [
              Tab(text: 'Coupons'),
              Tab(text: 'Offers'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CouponList(), // Coupon List
            OffersScreen(),
          ],
        ),
      ),
    );
  }
}
