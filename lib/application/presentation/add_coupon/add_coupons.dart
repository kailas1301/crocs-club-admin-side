import 'package:crocsclub_admin/application/business_logic/coupon/bloc/coupon_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/models/coupon.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCouponForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final TextEditingController minimumPriceController = TextEditingController();
  AddCouponForm({super.key, required this.id});

  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const SubHeadingTextWidget(title: 'Add Coupon'),
      ),
      body: BlocListener<CouponBloc, CouponState>(
        listener: (context, state) {
          if (state is AddCouponInProgress) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Container(
                alignment: Alignment.center,
                child: const AlertDialog(
                  content: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (state is AddCouponSuccess) {
            Navigator.of(context).pop();
            showCustomSnackbar(
                context, state.message, kGreenColour, kblackColour);
          } else if (state is AddCouponFailure) {
            Navigator.of(context).pop();
            showCustomSnackbar(context, state.error, kRedColour, kwhiteColour);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  labelText: 'Name',
                  controller: nameController,
                  hintText: 'Coupon Name',
                  validatorFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a coupon name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  labelText: 'Discount %',
                  controller: percentageController,
                  keyboardType: TextInputType.number,
                  hintText: 'Discount Percentage (1-99)',
                  validatorFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a discount percentage';
                    }
                    int percentage = int.tryParse(value) ?? 0;
                    if (percentage < 1 || percentage > 99) {
                      return 'Please enter a percentage between 1 and 99';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormFieldWidget(
                  labelText: 'Min Price',
                  controller: minimumPriceController,
                  keyboardType: TextInputType.number,
                  hintText: 'Enter the Minimum Price',
                  validatorFunction: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a minimum price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButtonWidget(
                  buttonText: 'Add Coupon',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      // Create a Coupon object from the form data
                      Coupon coupon = Coupon(
                        isAvailable: true,
                        name: nameController.text,
                        discountPercentage:
                            int.parse(percentageController.text),
                        minimumPrice: int.parse(minimumPriceController.text),
                      );
                      // Access the CouponBloc using BlocProvider and add the AddCouponEvent
                      context
                          .read<CouponBloc>()
                          .add(AddCouponEvent(coupon: coupon));

                      nameController.clear();
                      percentageController.clear();
                      minimumPriceController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
