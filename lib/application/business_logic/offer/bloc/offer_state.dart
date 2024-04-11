part of 'offer_bloc.dart';

@immutable
sealed class OfferState {}

final class OfferInitial extends OfferState {}

class OfferLoading extends OfferState {}

class OfferAdded extends OfferState {}

class OfferError extends OfferState {
  final String errorMessage;

  OfferError(this.errorMessage);
}

class OffersLoaded extends OfferState {
  final List<CategoryOffer> offers;

  OffersLoaded(this.offers);
}

class OfferDeleted extends OfferState {
  final String message;

  OfferDeleted(this.message);
}

class OfferDeletedError extends OfferState {
  final String message;

  OfferDeletedError(this.message);
}
