part of 'product_offer_bloc.dart';

@immutable
sealed class ProductOfferEvent {}

class AddProductOfferEvent extends ProductOfferEvent {
  final ProductOffer productOffer;

  AddProductOfferEvent({required this.productOffer});
}

class GetProductOffersEvent extends ProductOfferEvent {}

class ExpireProductOfferEvent extends ProductOfferEvent {
  final int offerId;

  ExpireProductOfferEvent({required this.offerId});
}
