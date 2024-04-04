import 'dart:io';
import 'package:crocsclub_admin/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/models/product.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textformfield_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:crocsclub_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddInventoryItemScreen extends StatelessWidget {
  final List<String> sizes = [
    'W4',
    'W5',
    'W6',
    'W7',
    'W8',
    'W9',
    'W10',
    'M4',
    'M5',
    'M6',
    'M7',
    'M8',
    'M10',
    'K1',
    'K2',
    'K3',
    'K4'
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  AddInventoryItemScreen(
      {super.key, required this.categoryName, required this.id});

  final String categoryName;
  final int id;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? selectedSize = sizes[0];
    File? image;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Add Product'),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductLoading) {
            const Center(child: CircularProgressIndicator());
          } else if (state is ImagePicked) {
            image = state.imageFile;
          } else if (state is ProductPosted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product Added Successfully'),
                backgroundColor: kGreenColour,
              ),
            );
          } else if (state is ProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('There was an error while adding.'),
                backgroundColor: kRedColour,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<ProductBloc>(context).add(PickImage());
                    },
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * .3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 184, 184, 184)
                                .withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: image == null
                          ? const Icon(Icons.photo, size: 50)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ), // Display selected image
                            ),
                    ),
                  ),
                  kSizedBoxH20,
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 184, 184, 184)
                              .withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        value: selectedSize,
                        hint: const Text('Select Size'),
                        items: sizes.map((size) {
                          return DropdownMenuItem<String>(
                            value: size,
                            child: Text(size),
                          );
                        }).toList(),
                        onChanged: (value) {
                          selectedSize = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a size.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid Product name';
                      }
                      return null; // Valid
                    },
                    hintText: 'Product Name',
                    controller: nameController,
                  ),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    keyboardType: TextInputType.number,
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid Stock';
                      }
                      return null; // Valid
                    },
                    hintText: 'Product Stock',
                    controller: stockController,
                  ),
                  kSizedBoxH10,
                  TextFormFieldWidget(
                    keyboardType: TextInputType.number,
                    validatorFunction: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid price';
                      }
                      return null; // Valid
                    },
                    hintText: 'Product Price',
                    controller: priceController,
                  ),
                  kSizedBoxH20,
                  ElevatedButtonWidget(
                    buttonText: 'Add Product',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final product = Product(
                            categoryId: id,
                            image: image,
                            productName: nameController.text,
                            size: selectedSize ?? '',
                            stock: int.parse(stockController.text),
                            price: double.parse(priceController.text));
                        BlocProvider.of<ProductBloc>(context)
                            .add(PostProduct(product: product));
                      } else {
                        showCustomSnackbar(
                            context,
                            'Please fix form errors before submitting.',
                            kRedColour,
                            kwhiteColour);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
