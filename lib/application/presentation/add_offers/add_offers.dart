import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class AddOfferForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  AddOfferForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: const AppBarTextWidget(title: 'Add Offer')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormFieldWidget(
                hintText: 'Offer Name',
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid offer name';
                  }
                  return null; // Valid
                },
                controller: nameController,
              ),
              kSizedBoxH10,
              TextFormFieldWidget(
                hintText: 'Discount percentage',
                controller: percentageController,
                keyboardType: TextInputType.number,
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
              kSizedBoxH20,
              ElevatedButtonWidget(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {}
                  },
                  buttonText: 'Add Coupon')
            ],
          ),
        ),
      ),
    );
  }
}
