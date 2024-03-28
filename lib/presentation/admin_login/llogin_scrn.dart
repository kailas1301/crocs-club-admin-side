import 'package:crocsclub_admin/business_logic/login/bloc/login_bloc_bloc.dart';
import 'package:crocsclub_admin/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocsclub_admin/utils/constants.dart';
import 'package:crocsclub_admin/utils/functions/functions.dart';
import 'package:crocsclub_admin/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/utils/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: kwhiteColour,
      body: BlocListener<LoginBlocBloc, LoginBlocState>(
        listener: (context, state) {
          if (state is LoginBlocLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(child: CircularProgressIndicator());
              },
            );
          } else if (state is LoginBlocSuccess) {
            showCustomSnackbar(
                context, 'Successfully logged in', Colors.green, Colors.black);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
              (route) => false,
            );
          } else if (state is LoginBlocError) {
            showCustomSnackbar(context, 'Log in was not successfull',
                Colors.white, Colors.black);
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Crocs logo
                  Image.asset(
                    'assets/images/CROCS.png',
                    height: 100,
                    width: 100,
                  ),
                  kSizedBoxH20, // Spacing

                  // Email text field
                  TextFormFieldWidget(
                    controller: emailController,
                    hintText: 'E-mail',
                    prefixIcon: Icons.email,
                    errorText: 'Please enter valid E-mail',
                  ),
                  kSizedBoxH20, // Spacing

                  // Password text field
                  TextFormFieldWidget(
                    prefixIcon: Icons.password,
                    controller: passwordController,
                    hintText: 'Password',
                    errorText: 'Please enter a valid password',
                  ),
                  kSizedBoxH20, // Spacing

                  // Login button
                  ElevatedButtonWidget(
                    buttonText: 'Log In',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginBlocBloc>(context)
                            .add(AdminLoginButtonPressed(
                          email: emailController.text,
                          password: passwordController.text,
                        ));
                      }
                    },
                  ),

                  kSizedBoxH20, // Spacing
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
