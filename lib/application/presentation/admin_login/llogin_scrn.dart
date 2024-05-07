import 'package:crocsclub_admin/application/business_logic/login/bloc/login_bloc_bloc.dart';
import 'package:crocsclub_admin/application/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
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
                context, 'Successfully logged in', kGreenColour, kwhiteColour);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
              (route) => false,
            );
          } else if (state is LoginBlocError) {
            Navigator.pop(context);
            showCustomSnackbar(context, 'Check username and password',
                kRedColour, kwhiteColour);
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
                    labelText: 'Username',
                    controller: emailController,
                    hintText: 'Enter Your Username',
                    prefixIcon: Icons.email,
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username is required';
                      }
                      // final emailRegex = RegExp(
                      //   r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      //   caseSensitive: false,
                      //   multiLine: false,
                      // );
                      // if (!emailRegex.hasMatch(value)) {
                      //   return 'Please enter a valid E-mail';
                      // }
                      return null; // Valid
                    },
                  ),
                  kSizedBoxH20, // Spacing

                  // Password text field
                  TextFormFieldWidget(
                    labelText: 'Password',
                    prefixIcon: Icons.password,
                    controller: passwordController,
                    hintText: 'Enter Your Password',
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null; // Valid
                    },
                  ),
                  kSizedBoxH20, // Spacing

                  // Login button
                  ElevatedButtonWidget(
                    buttonText: 'Log In',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginBlocBloc>(context).add(
                            AdminLoginButtonPressed(
                                email: emailController.text,
                                password: passwordController.text));
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
