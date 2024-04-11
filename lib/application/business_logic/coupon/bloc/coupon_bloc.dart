import 'package:bloc/bloc.dart';
import 'package:crocsclub_admin/data/services/coupon.dart';
import 'package:crocsclub_admin/domain/models/coupon.dart';
import 'package:meta/meta.dart';
part 'coupon_event.dart';
part 'coupon_state.dart';

class CouponBloc extends Bloc<CouponEvent, CouponState> {
  final CouponServices couponServices = CouponServices();

  CouponBloc() : super(CouponInitial()) {
    on<AddCouponEvent>((event, emit) async {
      emit(AddCouponInProgress());
      try {
        final response = await couponServices.addCoupon(event.coupon);
        if (response == 'Coupon added successfully') {
          emit(AddCouponSuccess(message: response));
        } else if (response == 'coupon already exist') {
          emit(AddCouponFailure(error: 'Coupon already exists'));
        } else {
          emit(AddCouponFailure(error: 'Coupon was not added'));
        }
      } catch (e) {
        emit(AddCouponFailure(error: e.toString()));
      }
    });

    on<FetchCoupons>((event, emit) async {
      emit(CouponLoading());
      try {
        final List<Coupon> coupons = await couponServices.getAllCoupons();
        emit(CouponsLoaded(coupons));
      } catch (e) {
        emit(CouponError(e.toString()));
      }
    });

    on<UpdateCouponEvent>((event, emit) async {
      emit(CouponUpdating());
      try {
        final response = await couponServices.updateCoupon(event.coupon);
        if (response == 'Successfully edited coupon') {
          final List<Coupon> coupons = await couponServices.getAllCoupons();
          emit(CouponUpdated(response));
          emit(CouponsLoaded(coupons));
        } else {
          emit(CouponError('Failed to update coupon'));
        }
      } catch (e) {
        emit(CouponError(e.toString()));
      }
    });
  }
}
