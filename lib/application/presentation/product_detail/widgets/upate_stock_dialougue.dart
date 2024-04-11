import 'package:crocsclub_admin/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/models/product.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateStockWidget extends StatelessWidget {
  const UpdateStockWidget({
    super.key,
    required this.stockController,
    required this.product,
  });

  final TextEditingController stockController;
  final ProductFromApi product;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const HeadingTextWidget(title: 'Update Stock'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SubHeadingTextWidget(
            title: 'Old Stock: ${product.stock}',
            textColor: kDarkGreyColour,
          ),
          kSizedBoxH10,
          TextFormFieldWidget(
            labelText: 'Stock',
            controller: stockController,
            keyboardType: TextInputType.number,
            hintText: 'New Stock',
            validatorFunction: (value) {
              if (value == null || value.isEmpty) {
                return 'New Stock is required';
              } else if (int.parse(value) <= 0) {
                return 'Should be greater than 0';
              }
              return null; // Valid
            },
          )
        ],
      ),
      actions: [
        ElevatedButtonWidget(
          textsize: 12,
          buttonText: 'Update',
          onPressed: () {
            if (int.parse(stockController.text) >= 0 &&
                stockController.text.isNotEmpty) {
              BlocProvider.of<ProductBloc>(context).add(
                UpdateStockEvent(
                    productId: product.id,
                    newStock: int.parse(stockController.text)),
              );
            } else {
              showCustomSnackbar(context, "The stock was not updated",
                  kRedColour, kwhiteColour);
              Navigator.of(context).pop();
            }
          },
        ),
        ElevatedButtonWidget(
          buttonText: 'Cancel',
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        ),
      ],
    );
  }
}
