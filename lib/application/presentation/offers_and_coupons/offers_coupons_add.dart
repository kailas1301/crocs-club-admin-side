import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class OffersAndCouponsAddingScreen extends StatelessWidget {
  const OffersAndCouponsAddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const AppBarTextWidget(title: 'Offers and Coupons'),
          bottom: const TabBar(
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

class CouponList extends StatelessWidget {
  const CouponList({super.key});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => kSizedBoxH10,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 184, 184, 184).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Coupon Name'),
                        kSizedBoxH10,
                        Text('Discount Percentage: 10%'),
                      ],
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                  ]),
            ),
          ),
        );
      },
    );
  }
}

class OffersScreen extends StatelessWidget {
  const OffersScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => kSizedBoxH10,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 184, 184, 184).withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Coupon Name'),
                        kSizedBoxH10,
                        Text('Discount Percentage: 10%'),
                      ],
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.delete)),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
