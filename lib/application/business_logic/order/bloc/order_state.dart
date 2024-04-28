part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  OrderLoaded(this.orders);
}

class OrderConfirmed extends OrderState {}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}

class OrderAlreadyApproved extends OrderState {
  final String message;
  OrderAlreadyApproved(this.message);
}

class OrderCompletionError extends OrderState {
  final String message;
  OrderCompletionError(this.message);
}
