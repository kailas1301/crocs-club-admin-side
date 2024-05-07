import 'package:crocsclub_admin/application/business_logic/coupon/bloc/coupon_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/couponvalidtoggle/bloc/coupon_valid_toggle_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/models/coupon.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CouponList extends StatelessWidget {
  const CouponList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponBloc, CouponState>(
      listener: (context, state) {
        if (state is CouponUpdated) {
          showCustomSnackbar(context, 'Coupon successfully updated',
              kGreenColour, kDarkGreyColour);
        } else if (state is CouponUpdateError) {
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
            separatorBuilder: (context, index) => const SizedBox(
              height: 5,
            ),
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
                      color: kAppColorlight,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 184, 184, 184)
                              .withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SubHeadingTextWidget(
                                  title: coupon.name), // Display coupon name
                              kSizedBoxH10,
                              SubHeadingTextWidget(
                                title:
                                    'Discount Percentage: ${coupon.discountPercentage}%',
                                textColor: kDarkGreyColour,
                                textsize: 14,
                              ),
                              kSizedBoxH10,
                              SubHeadingTextWidget(
                                title: 'Minimum Price: ₹${coupon.minimumPrice}',
                                textColor: kDarkGreyColour,
                                textsize: 14,
                              ),
                              kSizedBoxH10,
                              SubHeadingTextWidget(
                                title: coupon.isAvailable == true
                                    ? 'Valid'
                                    : 'Not Valid',
                                textColor: coupon.isAvailable == true
                                    ? kGreenColour
                                    : kRedColour,
                                textsize: 16,
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () {
                              showEditCouponDialog(context, coupon);
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
            child: SubHeadingTextWidget(title: 'No coupon found'),
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

// to show the editing of the coupon
void showEditCouponDialog(BuildContext context, Coupon coupon) {
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
        title: const SubHeadingTextWidget(title: 'Edit Coupon'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormFieldWidget(
              hintText: 'Enter the name',
              controller: nameController,
              labelText: 'Name',
            ),
            kSizedBoxH10,
            TextFormFieldWidget(
              hintText: 'Enter the Percentage',
              controller: percentageController,
              labelText: 'Discount Percentage',
              keyboardType: TextInputType.number,
            ),
            kSizedBoxH10,
            TextFormFieldWidget(
              hintText: 'Enter the Min Price',
              controller: minimumPriceController,
              labelText: 'Minimum Price',
              keyboardType: TextInputType.number,
            ),
            kSizedBoxH10,
            Row(
              children: [
                const SubHeadingTextWidget(title: 'Offer is valid'),
                kSizedBoxW20,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButtonWidget(
                buttonText: 'Cancel',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              BlocBuilder<CouponValidToggleBloc, CouponValidToggleState>(
                builder: (context, state) {
                  return ElevatedButtonWidget(
                    buttonText: 'Save',
                    onPressed: () {
                      // Dispatch an event to update the coupon with the new data
                      BlocProvider.of<CouponBloc>(context).add(
                        UpdateCouponEvent(
                          coupon: Coupon(
                            id: coupon.id,
                            name: nameController.text,
                            discountPercentage:
                                int.parse(percentageController.text),
                            minimumPrice:
                                int.parse(minimumPriceController.text),
                            isAvailable: isAvailable,
                          ),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}
