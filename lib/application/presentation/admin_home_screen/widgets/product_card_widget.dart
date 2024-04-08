import 'package:cached_network_image/cached_network_image.dart';
import 'package:crocsclub_admin/application/presentation/product_detail/product_detail.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/models/product.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:crocsclub_admin/main.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductFromApi product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ProductDetail(product: product),
      )),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: CachedNetworkImage(
                    height: screenHeight * .25,
                    imageUrl: product.image[0],
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                        alignment: Alignment.center,
                        width: 24,
                        height: 24,
                        child: const CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SubHeadingTextWidget(title: product.productName)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SubHeadingTextWidget(
                        textColor: kGreenColour,
                        title: '₹ ${product.price.floor().toString()}'),
                    SubHeadingTextWidget(
                      title: 'Size:${product.size}',
                      textColor: kDarkGreyColour,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
