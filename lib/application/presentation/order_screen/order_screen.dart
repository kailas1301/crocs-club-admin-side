import 'package:crocsclub_admin/application/business_logic/order/bloc/order_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crocsclub_admin/domain/models/order.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OrderBloc>(context).add(LoadOrders(1));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const AppBarTextWidget(title: 'Orders'),
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderConfirmed) {
            showCustomSnackbar(
                context, 'Order approved', kGreenColour, kwhiteColour);
          }
          if (state is OrderAlreadyApproved) {
            showCustomSnackbar(
                context, 'Order already approved', kRedColour, kwhiteColour);
          }
          if (state is OrderCompletionError) {
            showCustomSnackbar(
                context, 'Order was not approved', kRedColour, kwhiteColour);
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderLoaded) {
            return ListView.builder(
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                final Order order = state.orders[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ListTile(
                      title: SubHeadingTextWidget(
                          textColor: kDarkGreyColour,
                          textsize: 16,
                          title: 'Name: ${order.name}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SubHeadingTextWidget(
                              textColor: kDarkGreyColour,
                              textsize: 14,
                              title: 'House Name: ${order.houseName}'),
                          SubHeadingTextWidget(
                              textColor: kDarkGreyColour,
                              textsize: 14,
                              title: 'City: ${order.city}'),
                          SubHeadingTextWidget(
                              textColor: kDarkGreyColour,
                              textsize: 14,
                              title: 'Final Price: ${order.finalPrice}'),
                          SubHeadingTextWidget(
                              textColor: kDarkGreyColour,
                              textsize: 14,
                              title: 'Payment Status: ${order.paymentStatus}'),
                          SubHeadingTextWidget(
                              textsize: 14,
                              textColor: kDarkGreyColour,
                              title: 'Phone: ${order.phone}'),
                        ],
                      ),
                      trailing: order.paymentStatus == 'PAID'
                          ? const SubHeadingTextWidget(
                              textColor: kGreenColour,
                              textsize: 15,
                              title: 'Completed')
                          : order.paymentStatus == 'RETURNED TO WALLET'
                              ? const SubHeadingTextWidget(
                                  textColor: kRedColour,
                                  textsize: 14,
                                  title: 'Returned')
                              : ElevatedButtonWidget(
                                  textsize: 11,
                                  buttonText: 'Confirm',
                                  onPressed: () {
                                    BlocProvider.of<OrderBloc>(context).add(
                                        ApproveOrder(int.parse(order.orderId)));
                                  },
                                ),
                    ),
                  ),
                );
              },
            );
          } else if (state is OrderAlreadyApproved) {
            return const Center(
                child: SubHeadingTextWidget(title: 'Already approved'));
          } else {
            return const Center(child: CircularProgressIndicator());
// Plaeholder for other states
          }
        },
      ),
    );
  }
}
