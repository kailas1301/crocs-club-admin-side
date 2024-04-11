part of 'coupon_valid_toggle_bloc.dart';

@immutable
sealed class CouponValidToggleEvent {}

class ToggleChanged extends CouponValidToggleEvent {
  final bool isValid;

  ToggleChanged({required this.isValid});
}

class ToggleInitial extends CouponValidToggleEvent {}
