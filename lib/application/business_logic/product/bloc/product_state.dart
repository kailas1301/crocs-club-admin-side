part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductFromApi> products;

  ProductLoaded({required this.products});
}

final class ProductPosted extends ProductState {}

final class ImagePicked extends ProductState {
  final File imageFile;

  ImagePicked({required this.imageFile});
}

final class ProductStockUpdated extends ProductState {}

final class ProductDeleted extends ProductState {}

final class ProductError extends ProductState {}
