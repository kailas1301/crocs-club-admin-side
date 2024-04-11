import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'coupon_valid_toggle_event.dart';
part 'coupon_valid_toggle_state.dart';

class CouponValidToggleBloc
    extends Bloc<CouponValidToggleEvent, CouponValidToggleState> {
  CouponValidToggleBloc() : super(CouponValidToggleInitial()) {
    on<ToggleInitial>((event, emit) {
      emit(ToggleInitialState());
    });

    on<ToggleChanged>((event, emit) {
      try {
        if (event.isValid == false) {
          emit(CouponNotValid());
        } else if (event.isValid == true) {
          emit(CouponValid());
        }
      } catch (e) {
        emit(CouponNotValid());
      }
    });
  }
}
