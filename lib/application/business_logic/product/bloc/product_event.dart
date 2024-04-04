part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProducts extends ProductEvent {}

class PostProduct extends ProductEvent {
  final Product product;

  PostProduct({required this.product});
}

class PickImage extends ProductEvent {}

class UpdateStockEvent extends ProductEvent {
  final int productId;
  final int newStock;

  UpdateStockEvent({required this.productId, required this.newStock});
}

class DeleteProductEvent extends ProductEvent {
  final int productId;

  DeleteProductEvent({required this.productId});
}
