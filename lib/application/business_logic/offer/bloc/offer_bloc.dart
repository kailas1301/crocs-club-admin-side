import 'package:bloc/bloc.dart';
import 'package:crocsclub_admin/data/services/offers.dart';
import 'package:crocsclub_admin/domain/models/category_offer.dart';
import 'package:meta/meta.dart';
part 'offer_event.dart';
part 'offer_state.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  OfferServices offerServices = OfferServices();
  OfferBloc() : super(OfferInitial()) {
    on<AddOfferEvent>((event, emit) async {
      emit(OfferLoading());
      try {
        final result =
            await offerServices.addCategoryOffer(event.categoryOffer);
        if (result == 'offer added successfully') {
          emit(OfferAdded());
        } else if (result == 'offer already exists') {
          emit(OfferError('offer already exists'));
        } else {
          emit(OfferError('Failed to add offer:'));
        }
      } catch (e) {
        emit(OfferError('Failed to add offer:'));
      }
    });

    on<GetOffersEvent>((event, emit) async {
      emit(OfferLoading());
      try {
        final offerList = await offerServices.getAllCategoryOffers();
        emit(OffersLoaded(offerList));
      } catch (e) {
        emit(OfferError('Failed to retrieve offers'));
      }
    });

    on<ExpireOfferEvent>((event, emit) async {
      emit(OfferLoading());
      try {
        final response = await offerServices.deleteCategoryOffer(event.offerId);
        if (response == 200) {
          emit(OfferDeletedState('Offer was succesffully deleted'));
          final offerList = await offerServices.getAllCategoryOffers();
          emit(OffersLoaded(offerList));
        } else {
          emit(OfferDeletedError('Frailed to delete offer'));
        }
      } catch (e) {
        emit(OfferError('Failed to delete offer'));
      }
    });
  }
}
