import 'package:crocsclub_admin/application/presentation/add_coupon/add_coupons.dart';
import 'package:crocsclub_admin/application/presentation/add_offers/add_offers.dart';
import 'package:crocsclub_admin/application/presentation/add_product/add_product.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

void showSelectionDialog(
  BuildContext context,
  int id,
  String categoryName,
) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const SubHeadingTextWidget(title: 'Select what to add'),
        content: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButtonWidget(
                    width: 280,
                    buttonText: 'Add Product',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddInventoryItemScreen(
                          id: id,
                          categoryName: categoryName,
                        ),
                      ));
                    }),
                kSizedBoxH10,
                ElevatedButtonWidget(
                  width: 280,
                  buttonText: 'Add Coupon',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddCouponForm()));
                  },
                ),
                kSizedBoxH10,
                ElevatedButtonWidget(
                  width: 280,
                  buttonText: 'Add Offer',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddOfferForm()));
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
