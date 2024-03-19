import 'package:crocsclub_admin/business_logic/login/bloc/login_bloc_bloc.dart';
import 'package:crocsclub_admin/presentation/admin_home_screen/admin_home_scrn.dart';
import 'package:crocsclub_admin/utils/constants.dart';
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
      backgroundColor: const Color(0xFFF2F2F2),
      body: BlocListener<LoginBlocBloc, LoginBlocState>(
        listener: (context, state) {
          // Handle different LoginBloc states here
          if (state is LoginBlocLoading) {
            // Show a loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(child: CircularProgressIndicator());
              },
            );
          } else if (state is LoginBlocSuccess) {
            // Navigate to the home screen or perform other actions on successful login
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminHome(),
                ),
                (route) => false); // Assuming '/home' is your home screen route
          } else if (state is LoginBlocError) {
            print('error while logging is ${state.errorText}');
            // Show an error message based on the error state
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorText),
              ),
            );
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
                    'assets/images/pngegg.png',
                    height: 100,
                    width: 100,
                  ),
                  kSizedBoxH20, // Spacing

                  // Email text field
                  TextFormFieldWidget(
                    controller: emailController,
                    labelText: 'E-mail',
                    prefixIcon: Icons.email,
                    errorText: 'Please enter valid E-mail',
                  ),
                  kSizedBoxH20, // Spacing

                  // Password text field
                  TextFormFieldWidget(
                    controller: passwordController,
                    labelText: 'Password',
                    errorText: 'Please enter a valid password',
                  ),
                  kSizedBoxH20, // Spacing

                  // Login button
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginBlocBloc>(context)
                            .add(AdminLoginButtonPressed(
                          email: emailController.text,
                          password: passwordController.text,
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                    ),
                    child: const Text('Login'),
                  ),

                  const SizedBox(height: 15.0), // Spacing
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
