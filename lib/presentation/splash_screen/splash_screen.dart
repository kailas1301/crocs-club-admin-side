import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crocsclub_admin/business_logic/Splash/bloc/splash_bloc.dart';
import 'package:crocsclub_admin/business_logic/Splash/bloc/splash_event.dart';
import 'package:crocsclub_admin/business_logic/Splash/bloc/splash_state.dart';
import 'package:crocsclub_admin/presentation/admin_login/llogin_scrn.dart';
import 'package:crocsclub_admin/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocsclub_admin/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset('assets/images/logo.png'),
      splashIconSize: 400,
      nextScreen: BlocProvider<SplashBloc>(
        create: (context) => SplashBloc()..add(SetSplash()),
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) async {
            if (state is SplashLoadedState) {
              final userLoggedInToken = await getToken();
              if (userLoggedInToken == '') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const BottomNavBar()),
                );
              }
            }
          },
          child: const SizedBox(), // Placeholder widget while waiting for state
        ),
      ),
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000, // Adjust duration as needed
    );
  }
}
