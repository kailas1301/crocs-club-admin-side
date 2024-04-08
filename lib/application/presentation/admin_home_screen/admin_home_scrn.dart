import 'package:crocsclub_admin/application/business_logic/product/bloc/product_bloc.dart';
import 'package:crocsclub_admin/application/presentation/admin_home_screen/widgets/product_card_widget.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/drawer.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              },
              icon: const Icon(Icons.logout),
            )
          ],
          title: const AppBarTextWidget(
            title: 'Crocs Club',
          ),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {},
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
              child: SubHeadingTextWidget(
                title: 'No products available',
                textColor: kDarkGreyColour,
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      drawer: const DrawerScreen(),
    );
  }
}
