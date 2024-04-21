import 'package:bloc/bloc.dart';
import 'package:crocsclub_admin/data/services/order_services.dart';
import 'package:crocsclub_admin/domain/models/order.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderServices orderServices = OrderServices();
  OrderBloc() : super(OrderInitial()) {
    on<LoadOrders>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await orderServices.getAllOrders(event.page);
        emit(OrderLoaded(orders));
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });

    on<ApproveOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        final result = await orderServices.approveOrder(event.orderId);
        if (result == "success") {
          emit(OrderLoaded((state as OrderLoaded).orders)); // Refresh orders
        } else if (result == "already_approved") {
          emit(OrderAlreadyApproved("Order is already approved or processed"));
          final orders = await orderServices.getAllOrders(1);
          emit(OrderLoaded(orders));
        } else {
          emit(OrderError('Failed to approve order'));
          final orders = await orderServices.getAllOrders(1);
          emit(OrderLoaded(orders));
        }
      } catch (e) {
        emit(OrderError(e.toString()));
      }
    });
  }
}
