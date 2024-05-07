import 'package:crocsclub_admin/application/business_logic/product_offer/bloc/product_offer_bloc.dart';
import 'package:crocsclub_admin/application/presentation/offers_and_coupons/offers/category_offers_screen.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/models/product_offer.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductOfferScreen extends StatelessWidget {
  const ProductOfferScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductOfferBloc, ProductOfferState>(
      listener: (context, state) {
        if (state is ProductOfferDeleted) {
          showCustomSnackbar(context, 'Product Offer was successfully deleted',
              kRedColour, kDarkGreyColour);
        }
        if (state is ProductOfferError) {
          showCustomSnackbar(context, 'Product Offer was not deleted',
              kRedColour, kwhiteColour);
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
              return ProductOfferItem(offer: state.offers[index]);
            },
          );
        } else if (state is ProductOfferError) {
          return const Center(
            child: SubHeadingTextWidget(title: 'No offer found'),
          );
        } else {
          return const Center(
            child: SubHeadingTextWidget(title: 'No offer found'),
          );
        }
      },
    );
  }
}

class ProductOfferItem extends StatelessWidget {
  final ProductOfferModel offer;

  const ProductOfferItem({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: kAppColorlight,
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 184, 184, 184).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubHeadingTextWidget(title: offer.offerName),
                  kSizedBoxH10,
                  SubHeadingTextWidget(
                      textColor: kDarkGreyColour,
                      textsize: 14,
                      title:
                          'Discount Percentage: ${offer.discountPercentage}%'),
                  kSizedBoxH10,
                  SubHeadingTextWidget(
                    title: 'Product: ${offer.productId}',
                    textColor: kDarkGreyColour,
                    textsize: 14,
                  ),
                ],
              ),
              ConfirmDialougueBoxButton(
                icon: Icons.delete,
                onPressed: () {
                  BlocProvider.of<ProductOfferBloc>(context).add(
                      ExpireProductOfferEvent(productofferId: offer.id ?? 0));
                  Navigator.of(context).pop();
                },
                alertText: "Are you sure you want to delete this offer?",
                alertHeading: "Confirm Deletion",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
