part of 'product_offer_bloc.dart';

@immutable
sealed class ProductOfferState {}

final class ProductOfferInitial extends ProductOfferState {}

final class ProductOfferLoading extends ProductOfferState {}

final class ProductOfferLoaded extends ProductOfferState {
  final List<ProductOfferModel> offers;

  ProductOfferLoaded(this.offers);
}

// final class ProductOfferLoadedError extends ProductOfferState {
//   final String message;

//   ProductOfferLoadedError(this.message);
// }

final class ProductOfferAdded extends ProductOfferState {
  final String message;

  ProductOfferAdded(this.message);
}

// final class ProductOfferAddedError extends ProductOfferState {
//   final String message;

//   ProductOfferAddedError(this.message);
// }

final class ProductOfferDeleted extends ProductOfferState {
  final String message;

  ProductOfferDeleted(this.message);
}

// final class ProductOfferDeletedError extends ProductOfferState {
//   final String message;

//   ProductOfferDeletedError(this.message);
// }

final class ProductOfferError extends ProductOfferState {
  final String error;

  ProductOfferError(this.error);
}
