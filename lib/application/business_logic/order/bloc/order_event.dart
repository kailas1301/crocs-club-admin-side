part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class LoadOrders extends OrderEvent {
  final int page;
  LoadOrders(this.page);
}

class ApproveOrder extends OrderEvent {
  final int orderId;
  ApproveOrder(this.orderId);
}
