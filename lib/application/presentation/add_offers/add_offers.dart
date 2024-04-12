import 'package:crocsclub_admin/application/business_logic/offer/bloc/offer_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/models/category_offer.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddOfferForm extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  AddOfferForm({super.key, required this.id, required this.offerType});
  final int id;
  final String offerType;
  @override
  Widget build(BuildContext context) {
    return BlocListener<OfferBloc, OfferState>(
      listener: (context, state) {
        if (state is OfferLoading) {
          const CircularProgressIndicator();
        } else if (state is OfferAdded) {
          showCustomSnackbar(
              context, 'Successfully added offer', kGreenColour, kblackColour);
        } else if (state is OfferError) {
          showCustomSnackbar(
              context, 'Offer was not added', kGreenColour, kRedColour);
        }
      },
      child: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const AppBarTextWidget(title: 'Add Offer')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  labelText: 'Offer Name',
                  hintText: 'Enter the Offer Name',
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
                  labelText: 'Discount %',
                  hintText: 'Enter the percentage of Dicount',
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
                    if (formKey.currentState!.validate()) {
                      print('Category offer button was pressed');
                      final offer = CategoryOffer(
                        offerName: nameController.text,
                        categoryId: id,
                        discountPercentage:
                            int.parse(percentageController.text),
                      );
                      BlocProvider.of<OfferBloc>(context)
                          .add(AddOfferEvent(categoryOffer: offer));
                      nameController.clear();
                      percentageController.clear();
                    }
                  },
                  buttonText: 'Add Coupon',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
