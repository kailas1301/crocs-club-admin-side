import 'package:crocsclub_admin/application/business_logic/coupon/bloc/coupon_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/couponvalidtoggle/bloc/coupon_valid_toggle_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/models/coupon.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersAndCouponsAddingScreen extends StatelessWidget {
  const OffersAndCouponsAddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CouponBloc>(context).add(FetchCoupons());
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
    return BlocConsumer<CouponBloc, CouponState>(
      listener: (context, state) {
        if (state is CouponUpdated) {
          showCustomSnackbar(context, 'Coupon successfully updated',
              kGreenColour, kDarkGreyColour);
        } else if (state is CouponError) {
          showCustomSnackbar(
              context, 'Coupon was not updated', kRedColour, kDarkGreyColour);
        }
      },
      builder: (context, state) {
        if (state is CouponLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CouponUpdating) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CouponsLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => kSizedBoxH10,
            itemCount: state.coupons.length,
            itemBuilder: (context, index) {
              final coupon = state.coupons[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 184, 184, 184)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(coupon.name), // Display coupon name
                              const SizedBox(height: 10),
                              Text(
                                  'Discount Percentage: ${coupon.discountPercentage}%'),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              _showEditCouponDialog(context, coupon);
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is CouponError) {
          return const Center(
            child: Text('Please wait '),
          );
        } else {
          print(state);
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
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

void _showEditCouponDialog(BuildContext context, Coupon coupon) {
  BlocProvider.of<CouponValidToggleBloc>(context).add(ToggleInitial());
  TextEditingController nameController =
      TextEditingController(text: coupon.name);
  TextEditingController percentageController =
      TextEditingController(text: coupon.discountPercentage.toString());
  TextEditingController minimumPriceController =
      TextEditingController(text: coupon.minimumPrice.toString());
  bool isAvailable = coupon.isAvailable;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Coupon'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: percentageController,
              decoration:
                  const InputDecoration(labelText: 'Discount Percentage'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: minimumPriceController,
              decoration: const InputDecoration(labelText: 'Minimum Price'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                const Text('Offer is valid'),
                BlocBuilder<CouponValidToggleBloc, CouponValidToggleState>(
                  builder: (context, state) {
                    if (state is ToggleInitialState) {
                      return Switch(
                          value: isAvailable,
                          onChanged: (newValue) {
                            isAvailable = newValue;
                            BlocProvider.of<CouponValidToggleBloc>(context)
                                .add(ToggleChanged(isValid: newValue));
                          });
                    } else {
                      return Switch(
                          value: state is CouponValid ? true : false,
                          onChanged: (newValue) {
                            isAvailable = newValue;
                            BlocProvider.of<CouponValidToggleBloc>(context)
                                .add(ToggleChanged(isValid: newValue));
                          });
                    }
                  },
                ),
              ],
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          BlocBuilder<CouponValidToggleBloc, CouponValidToggleState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  // Dispatch an event to update the coupon with the new data
                  BlocProvider.of<CouponBloc>(context).add(
                    UpdateCouponEvent(
                      coupon: Coupon(
                        id: coupon.id,
                        name: nameController.text,
                        discountPercentage:
                            int.parse(percentageController.text),
                        minimumPrice: int.parse(minimumPriceController.text),
                        isAvailable: isAvailable,
                      ),
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              );
            },
          ),
        ],
      );
    },
  );
}
