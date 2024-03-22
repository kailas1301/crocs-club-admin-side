import 'package:crocsclub_admin/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    adminlogout(context);
                    showCustomSnackbar(context, 'Successfully logged out',
                        Colors.white, Colors.black);
                  },
                  icon: const Icon(Icons.logout))
            ],
            title: Text(
              'CROCS CLUB',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            elevation: 0,
            centerTitle: true),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            product: products[index],
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final String imageUrl;

  Product({required this.name, required this.imageUrl});
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// Sample product data
final List<Product> products = [
  Product(name: 'Product 1', imageUrl: 'https://via.placeholder.com/150'),
  Product(name: 'Product 2', imageUrl: 'https://via.placeholder.com/150'),
  Product(name: 'Product 3', imageUrl: 'https://via.placeholder.com/150'),
  Product(name: 'Product 4', imageUrl: 'https://via.placeholder.com/150'),
  Product(name: 'Product 5', imageUrl: 'https://via.placeholder.com/150'),
  Product(name: 'Product 6', imageUrl: 'https://via.placeholder.com/150'),
];
