import 'package:crocsclub_admin/domain/models/product.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key, required this.product}) : super(key: key);

  final ProductFromApi product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(product.productName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(child: buildImageListView(product.image, context)),
              Text(
                product.productName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Size: ${product.size}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  Text(
                    'Price: ₹${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Stock: ${product.stock}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Spacer(),
                  ElevatedButtonWidget(
                    buttonText: 'Update Stock',
                    onPressed: () {
                      // Handle update stock logic
                      // (e.g., navigate to a separate update screen)
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              ElevatedButtonWidget(
                buttonText: 'Delete Product',
                onPressed: () {
                  // Handle delete product logic
                  // (e.g., show confirmation dialog)
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageListView(List<String> imageUrls, BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          final imageUrl = imageUrls[index];
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * .9,
            ),
          );
        },
      ),
    );
  }
}
