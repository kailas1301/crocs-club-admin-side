part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({required this.products});
}

class ProductPosted extends ProductState {}

class ImagePicked extends ProductState {
  final File imageFile;

  ImagePicked({required this.imageFile});
}

class ProductError extends ProductState {}
