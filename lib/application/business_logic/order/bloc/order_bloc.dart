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
        final List<Order> orders = await orderServices.getAllOrders();
        emit(OrderLoaded(orders));
        print("successfully emited the orders");
      } catch (e) {
        print(e.toString());
        emit(OrderError(e.toString()));
      }
    });

    on<ApproveOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        final result1 = await orderServices.approveOrder(event.orderId);
        final result = await orderServices.approveOrder(event.orderId);
        print("result is $result");
        if (result == 200 && result1 == 200) {
          emit(OrderConfirmed());
          final List<Order> orders = await orderServices.getAllOrders();
          emit(OrderLoaded(orders));
        } else if (result == 201) {
          emit(OrderAlreadyApproved("Order is already approved or processed"));
          final orders = await orderServices.getAllOrders();
          emit(OrderLoaded(orders));
        } else {
          emit(OrderError('Failed to approve order'));
          print("failed to approve order");
          final orders = await orderServices.getAllOrders();
          emit(OrderLoaded(orders));
        }
      } catch (e) {
        emit(OrderCompletionError(e.toString()));
      }
    });
  }
}
