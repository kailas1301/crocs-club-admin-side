import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crocsclub_admin/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocsclub_admin/application/presentation/product_detail/product_detail.dart';
import 'package:crocsclub_admin/application/presentation/product_detail/widgets/add_images.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/models/product.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/icontext_button_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:crocsclub_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildProductDetail(BuildContext context, ProductFromApi product) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: product.image.length,
              itemBuilder: (context, index, realIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: CachedNetworkImage(
                    height: screenHeight * .5,
                    imageUrl: product.image[index],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) {
                      return Container(
                        alignment: Alignment.center,
                        width: 24,
                        height: 24,
                        child: const CircularProgressIndicator.adaptive(),
                      );
                    },
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              },
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
              ),
            ),
          ),
          kSizedBoxH30,
          Container(
            decoration: BoxDecoration(
              color: kwhiteColour,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingTextWidget(
                    title: product.productName.toUpperCase(),
                  ),
                  kSizedBoxH10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SubHeadingTextWidget(
                        textColor: kDarkGreyColour,
                        title: 'Size: ${product.size}',
                      ),
                      ElevatedButtonWidget(
                        width: screenWidth * .4,
                        textsize: 11,
                        buttonText: 'Add images',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddImagesScreen(
                              inventoryId: product.id,
                            ),
                          ));
                        },
                      ),
                    ],
                  ),
                  SubHeadingTextWidget(
                    textColor: kGreenColour,
                    title: 'Price: ₹${product.price.floor().toString()}',
                  ),
                  kSizedBoxH10,
                  SubHeadingTextWidget(
                    textColor: kDarkGreyColour,
                    title: 'Stock Left: ₹${product.stock}',
                  ),
                  kSizedBoxH30,
                  IconTextButtonWidget(
                    textwidget: const SubHeadingTextWidget(
                      title: 'Update Stock',
                      textColor: kwhiteColour,
                    ),
                    color: kAppPrimaryColor,
                    height: .08,
                    width: .6,
                    buttonText: 'Update Stock',
                    icon: Icons.edit,
                    onPressed: () {
                      showUpdateStockDialog(context, product);
                    },
                  ),
                  kSizedBoxH10,
                  IconTextButtonWidget(
                    textwidget: const SubHeadingTextWidget(
                      title: 'Delete Product',
                      textColor: kwhiteColour,
                    ),
                    color: kAppPrimaryColor,
                    height: .08,
                    width: .6,
                    buttonText: 'Delete Product',
                    icon: Icons.delete,
                    onPressed: () {
                      confirmDelete(
                        context: context,
                        id: product.id,
                        categoryName: product.productName,
                        onPressed: () {
                          BlocProvider.of<ProductBloc>(context).add(
                            DeleteProductEvent(productId: product.id),
                          );
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                  kSizedBoxH10
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
