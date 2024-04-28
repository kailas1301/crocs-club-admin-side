import 'package:crocsclub_admin/application/business_logic/payment/bloc/payment_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PaymentBloc>(context).add(LoadPaymentMethods());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Payment Methods'),
      ),
      body: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PaymentLoaded) {
            return ListView.builder(
              itemCount: state.paymentMethods.length,
              itemBuilder: (context, index) {
                final paymentMethod = state.paymentMethods[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: SubHeadingTextWidget(
                      title: paymentMethod.paymentName,
                      textColor: kDarkGreyColour,
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteConfirmationDialog(
                            context, paymentMethod.id);
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is PaymentError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unexpected state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPaymentDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

// to show a dialougue box to delete the paymentmethod
  void _showDeleteConfirmationDialog(
      BuildContext context, int paymentMethodId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const SubHeadingTextWidget(
              textColor: kDarkGreyColour, title: 'Confirm Delete'),
          content: const SubHeadingTextWidget(
              textColor: kDarkGreyColour,
              textsize: 14,
              title: 'Are you sure you want to delete this payment method?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButtonWidget(
                    buttonText: 'Cancel',
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                ElevatedButtonWidget(
                    buttonText: 'Delete',
                    onPressed: () {
                      BlocProvider.of<PaymentBloc>(context).add(
                          DeletePaymentMethod(
                              paymentMethodId: paymentMethodId));
                      Navigator.pop(context);
                    }),
              ],
            ),
          ],
        );
      },
    );
  }

// to add new payment method
  void _showAddPaymentDialog(BuildContext context) {
    TextEditingController _paymentNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const SubHeadingTextWidget(
              textColor: kDarkGreyColour,
              textsize: 16,
              title: 'Add Payment Method'),
          content: TextFormFieldWidget(
            hintText: 'Enter Payment Name',
            labelText: 'Payment Name',
            keyboardType: TextInputType.name,
            controller: _paymentNameController,
            validatorFunction: (p0) {
              if (_paymentNameController.text.isEmpty) {
                return 'Please enter a payment';
              }
            },
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButtonWidget(
                  buttonText: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButtonWidget(
                  buttonText: 'Add',
                  onPressed: () {
                    final paymentName = _paymentNameController.text;
                    if (paymentName.isNotEmpty) {
                      BlocProvider.of<PaymentBloc>(context)
                          .add(AddPaymentMethods(paymentName: paymentName));
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
