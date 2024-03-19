import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crocsclub_admin/business_logic/Splash/bloc/splash_bloc.dart';
import 'package:crocsclub_admin/business_logic/Splash/bloc/splash_event.dart';
import 'package:crocsclub_admin/business_logic/Splash/bloc/splash_state.dart';
import 'package:crocsclub_admin/presentation/on_boarding/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Center content vertically
        mainAxisSize: MainAxisSize.min, // Avoid taking full screen height
        children: [
          Image.asset('assets/images/splash.png'),
          const SizedBox(height: 20.0), // Add spacing between logo and text
          const Text(
            "Your App Name",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
      splashIconSize: 300,
      nextScreen: BlocProvider<SplashBloc>(
        create: (context) => SplashBloc()..add(SetSplash()),
        child: BlocConsumer<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashLoadedState) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OnBoardingScreen()),
              );
            }
          },
          builder: (context, state) {
            return Container(); // Placeholder widget while waiting for state
          },
        ),
      ),
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000, // Adjust duration as needed
    );
  }
}
