import 'package:crocsclub_admin/business_logic/Splash/bloc/splash_bloc.dart';
import 'package:crocsclub_admin/business_logic/category/bloc/category_bloc.dart';
import 'package:crocsclub_admin/business_logic/login/bloc/login_bloc_bloc.dart';
import 'package:crocsclub_admin/business_logic/nav_bar/bloc/navbar_bloc.dart';
import 'package:crocsclub_admin/business_logic/users/bloc/users_bloc.dart';
import 'package:crocsclub_admin/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

final http.Client httpClient = http.Client();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => LoginBlocBloc(httpClient)),
        BlocProvider(create: (_) => NavbarBloc()),
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(create: (_) => UsersBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
