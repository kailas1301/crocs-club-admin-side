import 'package:bloc/bloc.dart';
import 'package:crocsclub_admin/data/services/payment.dart';
import 'package:crocsclub_admin/domain/models/payment_model.dart';
import 'package:meta/meta.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentServices paymentServices = PaymentServices();
  PaymentBloc() : super(PaymentInitial()) {
    on<LoadPaymentMethods>((event, emit) async {
      emit(PaymentLoading());
      try {
        final paymentMethods = await paymentServices.getPaymentMethods();
        emit(PaymentLoaded(paymentMethods: paymentMethods));
      } catch (e) {
        emit(PaymentError(message: e.toString()));
      }
    });

    on<AddPaymentMethods>((event, emit) async {
      emit(PaymentLoading());
      try {
        final result =
            await paymentServices.addPaymentMethod(event.paymentName);
        if (result == 200) {
          emit(PaymentAdded());
          final paymentMethods = await paymentServices.getPaymentMethods();
          emit(PaymentLoaded(paymentMethods: paymentMethods));
        } else {
          emit(PaymentError(message: 'Payment method was not added'));
        }
      } catch (e) {
        emit(PaymentError(message: e.toString()));
      }
    });

    on<DeletePaymentMethod>((event, emit) async {
      emit(PaymentLoading());
      try {
        final result =
            await paymentServices.deletePaymentMethod(event.paymentMethodId);
        if (result == 200) {
          emit(PaymentDeleted());
        } else {
          emit(PaymentError(message: 'payment was not deleted'));
        }
        final paymentMethods = await paymentServices.getPaymentMethods();
        emit(PaymentLoaded(paymentMethods: paymentMethods));
      } catch (e) {
        emit(PaymentError(message: e.toString()));
      }
    });
  }
}
