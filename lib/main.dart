import 'package:crocsclub_admin/application/business_logic/Splash/bloc/splash_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/category/bloc/category_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/coupon/bloc/coupon_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/couponvalidtoggle/bloc/coupon_valid_toggle_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/login/bloc/login_bloc_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/multiple_image/bloc/multiple_image_picking_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/nav_bar/bloc/navbar_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/offer/bloc/offer_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/payment/bloc/payment_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/product_offer/bloc/product_offer_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/users/bloc/users_bloc.dart';
import 'package:crocsclub_admin/application/presentation/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

final http.Client httpClient = http.Client();
late double screenWidth;
late double screenHeight;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => LoginBlocBloc(httpClient)),
        BlocProvider(create: (_) => NavbarBloc()),
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(create: (_) => UsersBloc()),
        BlocProvider(create: (_) => ProductBloc()),
        BlocProvider(create: (_) => MultipleImagePickingBloc()),
        BlocProvider(create: (_) => CouponBloc()),
        BlocProvider(create: (_) => CouponValidToggleBloc()),
        BlocProvider(create: (_) => OfferBloc()),
        BlocProvider(create: (_) => ProductOfferBloc()),
        BlocProvider(create: (_) => PaymentBloc())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
