part of 'coupon_bloc.dart';

@immutable
sealed class CouponState {}

final class CouponInitial extends CouponState {}

class AddCouponInProgress extends CouponState {}

class AddCouponSuccess extends CouponState {
  final String message;

  AddCouponSuccess({required this.message});
}

class AddCouponFailure extends CouponState {
  final String error;

  AddCouponFailure({required this.error});
}

class CouponLoading extends CouponState {}

class CouponsLoaded extends CouponState {
  final List<Coupon> coupons;

  CouponsLoaded(this.coupons);
}

class CouponUpdating extends CouponState {}

class CouponUpdated extends CouponState {
  final String message;

  CouponUpdated(this.message);
}

class CouponError extends CouponState {
  final String error;

  CouponError(this.error);
}
