part of 'product_offer_bloc.dart';

@immutable
sealed class ProductOfferEvent {}

class AddProductOfferEvent extends ProductOfferEvent {
  final ProductOfferModel productOffer;

  AddProductOfferEvent({required this.productOffer});
}

class GetProductOffersEvent extends ProductOfferEvent {}

class ExpireProductOfferEvent extends ProductOfferEvent {
  final int productofferId;

  ExpireProductOfferEvent({required this.productofferId});
}
