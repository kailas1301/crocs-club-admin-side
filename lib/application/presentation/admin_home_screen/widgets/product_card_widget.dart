
import 'package:crocsclub_admin/application/presentation/product_detail/product_detail.dart';
import 'package:crocsclub_admin/domain/models/product.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  product.image[0],
                  fit: BoxFit.cover,
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
                  SubHeadingTextWidget(title: product.size),
                  SubHeadingTextWidget(
                      title: '₹ ${product.price.floor().toString()}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
