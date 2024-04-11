part of 'coupon_bloc.dart';

@immutable
sealed class CouponEvent {}

class AddCouponEvent extends CouponEvent {
  final Coupon coupon;

  AddCouponEvent({required this.coupon});
}

class FetchCoupons extends CouponEvent {}

class UpdateCouponEvent extends CouponEvent {
  final Coupon coupon;

  UpdateCouponEvent({required this.coupon});
}
