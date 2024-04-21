part of 'payment_bloc.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final List<PaymentMethod> paymentMethods;
  PaymentLoaded({required this.paymentMethods});
}

class PaymentAdded extends PaymentState {}

class PaymentDeleted extends PaymentState {}

class PaymentError extends PaymentState {
  final String message;
  PaymentError({required this.message});
}
