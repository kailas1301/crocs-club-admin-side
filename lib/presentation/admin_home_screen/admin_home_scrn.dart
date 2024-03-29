import 'package:crocsclub_admin/business_logic/product/bloc/product_bloc.dart';
import 'package:crocsclub_admin/data/models/product.dart';
import 'package:crocsclub_admin/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
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
              icon: const Icon(Icons.logout),
            ),
          ],
          title: Text(
            'CROCS CLUB',
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: state.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (BuildContext context, int index) {
                final productAtIndex = state.products[index];
                return ProductCard(product: productAtIndex);
              },
            );
          } else if (state is ProductError) {
            return const Center(
              child: Text('Failed to load products'),
            );
          } else {
            return const Center(
              child: Text('No products available'),
            );
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final ProductFromApi product;

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
                product.image[0],
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              product.productName,
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
