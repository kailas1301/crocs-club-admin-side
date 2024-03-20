import 'package:crocsclub_admin/utils/functions/functions.dart';
import 'package:crocsclub_admin/utils/widgets/elevatedbutton_widget.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButtonWidget(
              onPressed: () {
                adminlogout(context);
                showCustomSnackbar(context, 'Successfully logged out',
                    Colors.white, Colors.black);
              },
              buttonText: 'Log Out')),
    );
  }
}
