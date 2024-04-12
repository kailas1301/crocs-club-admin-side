import 'package:crocsclub_admin/application/business_logic/offer/bloc/offer_bloc.dart';
import 'package:crocsclub_admin/application/business_logic/product_offer/bloc/product_offer_bloc.dart';
import 'package:crocsclub_admin/application/presentation/offers_and_coupons/offers/category_offers_screen.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductOfferScreen extends StatelessWidget {
  const ProductOfferScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductOfferBloc, ProductOfferState>(
      listener: (context, state) {
        if (state is ProductOfferDeleted) {
          showCustomSnackbar(context, 'Offer was successfully deleted',
              kGreenColour, kDarkGreyColour);
        }
        if (state is ProductOfferDeletedError) {
          showCustomSnackbar(
              context, 'Offer was not deleted', kRedColour, kwhiteColour);
        }
      },
      builder: (context, state) {
        if (state is ProductOfferLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductOfferLoaded) {
          return ListView.separated(
            separatorBuilder: (context, index) => kSizedBoxH10,
            itemCount: state.offers.length,
            itemBuilder: (context, index) {
              return OfferItem(offer: state.offers[index]);
            },
          );
        } else if (state is OfferError) {
          return const Center(
            child: Text('no offer found'),
          );
        } else {
          return const Center(
            child: Text('no offer found'),
          );
        }
      },
    );
  }
}
