import 'package:bloc/bloc.dart';
import 'package:crocsclub_admin/data/services/offers.dart';
import 'package:crocsclub_admin/domain/models/product_offer.dart';
import 'package:meta/meta.dart';

part 'product_offer_event.dart';
part 'product_offer_state.dart';

class ProductOfferBloc extends Bloc<ProductOfferEvent, ProductOfferState> {
  OfferServices offerServices = OfferServices();
  ProductOfferBloc() : super(ProductOfferInitial()) {
    on<AddProductOfferEvent>((event, emit) async {
      emit(ProductOfferLoading());
      try {
        final result = await offerServices.addProductOffer(event.productOffer);
        if (result == 'offer added successfully') {
          emit(ProductOfferAdded('Offer succesfully added'));
        } else if (result == 'offer already exists') {
          emit(ProductOfferError('offer already exists'));
        } else {
          emit(ProductOfferError('Failed to add offer:'));
        }
      } catch (e) {
        emit(ProductOfferError('Failed to add offer:'));
      }
    });

    on<GetProductOffersEvent>((event, emit) async {
      emit(ProductOfferLoading());
      try {
        final offerList = await offerServices.getAllProductOffers();
        emit(ProductOfferLoaded(offerList));
      } catch (e) {
        emit(ProductOfferError('Failed to retrieve offers'));
      }
    });

    on<ExpireProductOfferEvent>((event, emit) async {
      emit(ProductOfferLoading());
      try {
        final response =
            await offerServices.deleteProductOffer(event.productofferId);
        if (response == 200) {
          emit(ProductOfferDeleted('Offer was succesffully deleted'));
          final offerList = await offerServices.getAllProductOffers();
          emit(ProductOfferLoaded(offerList));
        } else {
          emit(ProductOfferError('Failed to delete offer'));
        }
      } catch (e) {
        emit(ProductOfferError('Failed to delete offer'));
      }
    });
  }
}
