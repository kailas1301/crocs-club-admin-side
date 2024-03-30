import 'package:crocsclub_admin/application/business_logic/Splash/bloc/splash_event.dart';
import 'package:crocsclub_admin/application/business_logic/Splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SetSplash>((event, emit) {
      emit(SplashLoadingState());
      emit(SplashLoadedState());
    });
  }
}
