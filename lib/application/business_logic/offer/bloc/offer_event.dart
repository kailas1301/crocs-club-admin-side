part of 'offer_bloc.dart';

@immutable
sealed class OfferEvent {}

class AddOfferEvent extends OfferEvent {
  final CategoryOffer categoryOffer;

  AddOfferEvent({required this.categoryOffer});
}

class GetOffersEvent extends OfferEvent {}

class ExpireOfferEvent extends OfferEvent {
  final int offerId;

  ExpireOfferEvent({required this.offerId});
}
