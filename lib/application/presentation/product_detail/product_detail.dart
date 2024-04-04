import 'package:crocsclub_admin/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocsclub_admin/application/presentation/admin_home_screen/admin_home_scrn.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crocsclub_admin/domain/models/product.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final ProductFromApi product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTextWidget(title: product.productName.toUpperCase()),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductStockUpdated) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const AdminHome(),
                ),
                (route) => false);
            showCustomSnackbar(context, 'Sucessfully updated the stock',
                kGreenColour, kblackColour);
          }
          if (state is ProductDeleted) {
            showCustomSnackbar(context, 'Sucessfully deleted the stock',
                kGreenColour, kblackColour);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const AdminHome(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return buildProductDetail(context, product);
          } else {
            return const Center(child: SubHeadingTextWidget(title: ''));
          }
        },
      ),
    );
  }

  Widget buildProductDetail(BuildContext context, ProductFromApi product) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: kwhiteColour,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 62, 62, 62).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: product.image.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          product.image[index],
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                ),
                kSizedBoxH30,
                HeadingTextWidget(
                    title: 'Name: ${product.productName.toUpperCase()}'),
                kSizedBoxH10,
                HeadingTextWidget(
                  title: 'Size: ${product.size}',
                ),
                kSizedBoxH10,
                HeadingTextWidget(
                  title: 'Price: ₹${product.price.floor().toString()}',
                ),
                kSizedBoxH10,
                HeadingTextWidget(
                  title: 'Stock: ${product.stock}',
                ),
                kSizedBoxH10,
                ElevatedButtonWidget(
                  buttonText: 'Update Stock',
                  onPressed: () {
                    _showUpdateStockDialog(context, product);
                  },
                ),
                kSizedBoxH10,
                ElevatedButtonWidget(
                  buttonText: 'Delete Product',
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showUpdateStockDialog(BuildContext context, ProductFromApi product) {
    TextEditingController stockController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const HeadingTextWidget(title: 'Update Stock'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SubHeadingTextWidget(title: 'Old Stock: ${product.stock}'),
              kSizedBoxH10,
              TextFormFieldWidget(
                controller: stockController,
                keyboardType: TextInputType.number,
                hintText: 'New Stock',
                validatorFunction: (value) {
                  if (value == null || value.isEmpty) {
                    return 'New Stock is required';
                  } else if (int.parse(value) <= 0) {
                    return 'Should be greater than 0';
                  }
                  return null; // Valid
                },
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (int.parse(stockController.text) >= 0 &&
                    stockController.text.isNotEmpty) {
                  BlocProvider.of<ProductBloc>(context).add(
                    UpdateStockEvent(
                        productId: product.id,
                        newStock: int.parse(stockController.text)),
                  );
                  Navigator.of(context).pop();
                } else {
                  showCustomSnackbar(context, "The stock was not updated",
                      kRedColour, kwhiteColour);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
