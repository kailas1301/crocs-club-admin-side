import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navbar_event.dart';
part 'navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarInitial()) {
    on<HomePressed>((event, emit) => emit(HomeSelected()));
    on<AddProductPressed>((event, emit) => emit(AddCategorySelected()));
    on<OffersCouponsPressed>((event, emit) => emit(OffersCouponsSelected()));
    on<UserPressed>((event, emit) => emit(UserSelected()));
  }
}
