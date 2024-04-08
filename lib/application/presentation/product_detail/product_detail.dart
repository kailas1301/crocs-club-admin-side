import 'package:crocsclub_admin/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocsclub_admin/application/presentation/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:crocsclub_admin/application/presentation/product_detail/widgets/product_detail_widget.dart';
import 'package:crocsclub_admin/application/presentation/product_detail/widgets/upate_stock_dialougue.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crocsclub_admin/domain/models/product.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key, required this.product});

  final ProductFromApi product;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductBloc>(context).add(FetchProducts());
    return Scaffold(
      backgroundColor: kwhiteColour,
      appBar: AppBar(
        centerTitle: true,
        title: AppBarTextWidget(title: product.productName),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductStockUpdated) {
            BlocProvider.of<ProductBloc>(context).add(FetchProducts());
            Navigator.of(context).pop();
            showCustomSnackbar(context, 'Sucessfully updated the stock',
                kGreenColour, kblackColour);
          } else if (state is ImageUploadSuccess) {
            BlocProvider.of<ProductBloc>(context).add(FetchProducts());
            Navigator.of(context).pop();
            showCustomSnackbar(context, 'Sucessfully added the image',
                kGreenColour, kblackColour);
          } else if (state is ProductDeleted) {
            showCustomSnackbar(context, 'Sucessfully deleted the stock',
                kGreenColour, kblackColour);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const BottomNavBar(),
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
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

void showUpdateStockDialog(BuildContext context, ProductFromApi product) {
  TextEditingController stockController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UpdateStockWidget(
        stockController: stockController,
        product: product,
      );
    },
  );
}
