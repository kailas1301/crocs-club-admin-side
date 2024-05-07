import 'package:crocsclub_admin/application/presentation/add_offers/add_offers.dart';
import 'package:crocsclub_admin/application/presentation/product_detail/product_detail.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocsclub_admin/domain/models/product.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/icontext_button_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:crocsclub_admin/application/presentation/product_detail/widgets/add_images.dart';
import 'package:crocsclub_admin/application/business_logic/product/bloc/product_bloc.dart';

class CarouselIndicatorState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

Widget buildProductDetail(BuildContext context, ProductFromApi product) {
  return ChangeNotifierProvider(
    create: (context) => CarouselIndicatorState(), // Step 2: Provide the state
    child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<CarouselIndicatorState>(
          // Step 3: Consume the state
          builder: (context, indicatorState, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  child: CarouselSlider.builder(
                    itemCount: product.image.length,
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: CachedNetworkImage(
                          height: MediaQuery.of(context).size.height / 3,
                          imageUrl: product.image[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
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
                      onPageChanged: (index, reason) {
                        // Update the current index when page changes
                        Provider.of<CarouselIndicatorState>(context,
                                listen: false)
                            .setCurrentIndex(index);
                      },
                    ),
                  ),
                ),
                // Step 4: Add indicator widgets
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    product.image.length,
                    (index) => Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: indicatorState.currentIndex == index
                            ? Colors.blueAccent
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingTextWidget(
                        title: product.productName.toUpperCase(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubHeadingTextWidget(
                            textColor: kDarkGreyColour,
                            title: 'Size: ${product.size}',
                          ),
                          ElevatedButtonWidget(
                            width: screenWidth * .38,
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
                      kSizedBoxH10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SubHeadingTextWidget(
                            textColor: kGreenColour,
                            title:
                                'Price: ₹${product.price.floor().toString()}',
                          ),
                          ElevatedButtonWidget(
                            width: screenWidth * .38,
                            textsize: 11,
                            buttonText: 'Add offer',
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AddOfferForm(
                                        id: product.id,
                                        offerType: 'product',
                                      )));
                            },
                          ),
                        ],
                      ),
                      kSizedBoxH10,
                      SubHeadingTextWidget(
                        textColor: Colors.grey,
                        title: 'Stock Left: ${product.stock}',
                      ),
                      kSizedBoxH10,
                      IconTextButtonWidget(
                        textwidget: const SubHeadingTextWidget(
                          textsize: 13,
                          title: 'Update Stock',
                          textColor: Colors.white,
                        ),
                        color: kPrimaryDarkColor,
                        height: .08,
                        width: .45,
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
                          textsize: 13,
                          textColor: Colors.white,
                        ),
                        color: kRedColour,
                        height: .08,
                        width: .45,
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
                )
              ],
            );
          },
        ),
      ),
    ),
  );
}
