import 'package:crocsclub_admin/application/presentation/order_screen/order_screen.dart';
import 'package:crocsclub_admin/application/presentation/payment/payemnt_screen.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          kSizedBoxH30,
          kSizedBoxH30,
          kSizedBoxH30,
          ListTile(
            leading:
                const Icon(Icons.person), // Leading widget for this list tile
            title: const SubHeadingTextWidget(
              title: 'Orders',
              textColor: kDarkGreyColour,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OrderScreen(),
              ));
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.payment), // Leading widget for this list tile
            title: const SubHeadingTextWidget(
              title: 'Payment',
              textColor: kDarkGreyColour,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const PaymentScreen(),
              ));
            },
          ),
          ListTile(
              leading:
                  const Icon(Icons.logout), // Leading widget for this list tile
              title: const SubHeadingTextWidget(
                title: 'Log out',
                textColor: kDarkGreyColour,
              ),
              onTap: () {
                adminlogout(context);
              }),
        ],
      ),
    );
  }
}
