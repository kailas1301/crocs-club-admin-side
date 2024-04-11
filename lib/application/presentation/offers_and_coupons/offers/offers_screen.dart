import 'package:crocsclub_admin/application/business_logic/offer/bloc/offer_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/models/category_offer.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:crocsclub_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OfferBloc, OfferState>(
      listener: (context, state) {
        if (state is OfferDeleted) {
          showCustomSnackbar(context, 'Offer was successfully deleted',
              kGreenColour, kDarkGreyColour);
        } else if (state is OfferDeletedError) {
          showCustomSnackbar(
              context, 'Offer was not deleted', kRedColour, kwhiteColour);
        }
      },
      builder: (context, state) {
        if (state is OfferLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OffersLoaded) {
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
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class OfferItem extends StatelessWidget {
  final CategoryOffer offer;

  const OfferItem({super.key, required this.offer});

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
                    title: 'Category: ${offer.categoryId}',
                    textColor: kDarkGreyColour,
                    textsize: 14,
                  ),
                ],
              ),
              ConfirmDialougueBoxButton(
                icon: Icons.delete,
                onPressed: () {
                  BlocProvider.of<OfferBloc>(context)
                      .add(ExpireOfferEvent(offerId: offer.id ?? 0));
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

class ConfirmDialougueBoxButton extends StatelessWidget {
  const ConfirmDialougueBoxButton({
    super.key,
    required this.alertHeading,
    required this.alertText,
    required this.onPressed,
    required this.icon,
  });
  final String alertHeading;
  final String alertText;
  final void Function() onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: HeadingTextWidget(
                title: alertHeading,
              ),
              content: SubHeadingTextWidget(
                title: alertText,
                textColor: kDarkGreyColour,
                textsize: 15,
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButtonWidget(
                      width: screenWidth * .28,
                      buttonText: "Yes",
                      onPressed: onPressed,
                    ),
                    ElevatedButtonWidget(
                      width: screenWidth * .28,
                      buttonText: "No",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            );
          },
        );
      },
      icon: Icon(
        icon,
        size: 25,
      ),
    );
  }
}
