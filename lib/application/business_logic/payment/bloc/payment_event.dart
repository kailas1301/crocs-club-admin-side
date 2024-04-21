part of 'payment_bloc.dart';

@immutable
sealed class PaymentEvent {}

class LoadPaymentMethods extends PaymentEvent {}

class AddPaymentMethods extends PaymentEvent {
  final String paymentName;
  AddPaymentMethods({required this.paymentName});
}

class DeletePaymentMethod extends PaymentEvent {
  final int paymentMethodId;

  DeletePaymentMethod({required this.paymentMethodId});
}
