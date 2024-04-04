import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class AddCouponForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  final TextEditingController minimumPriceController = TextEditingController();
  AddCouponForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Add Coupon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormFieldWidget(
                controller: nameController,
                hintText: 'Coupon Name',
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a coupon name';
                  }
                  return null;
                },
              ),
              kSizedBoxH10,
              TextFormFieldWidget(
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
              kSizedBoxH10,
              TextFormFieldWidget(
                controller: minimumPriceController,
                keyboardType: TextInputType.number,
                hintText: 'Minimum Price',
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a minimum price';
                  }
                  return null;
                },
              ),
              kSizedBoxH20,
              ElevatedButtonWidget(
                buttonText: 'Add Coupon',
                onPressed: () {
                  if (formKey.currentState!.validate()) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
