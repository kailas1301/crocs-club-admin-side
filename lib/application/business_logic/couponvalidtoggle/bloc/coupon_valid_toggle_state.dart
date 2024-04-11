part of 'coupon_valid_toggle_bloc.dart';

@immutable
sealed class CouponValidToggleState {}

final class CouponValidToggleInitial extends CouponValidToggleState {}

class CouponValid extends CouponValidToggleState {}

class CouponNotValid extends CouponValidToggleState {}

class ToggleInitialState extends CouponValidToggleState {}
