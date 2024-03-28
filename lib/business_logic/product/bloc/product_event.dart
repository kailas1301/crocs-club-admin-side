part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class FetchProducts extends ProductEvent {}

class PostProduct extends ProductEvent {
  final Product product;

  PostProduct({required this.product});
}

class PickImage extends ProductEvent {}
