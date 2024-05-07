import 'dart:convert';
import 'package:crocsclub_admin/domain/models/order.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  Future<List<Order>> getAllOrders() async {
    final authToken = await getToken();
    const apiUrl = 'http://crocs.crocsclub.shop/admin/order/get';
    final headers = {
      'accept': 'application/json',
      'Authorization': authToken ?? '',
    };
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        print("the get order function was successfull");
        final responseData = jsonDecode(response.body)['data'];
        final List<Order> orderlist = [];
        for (var element in responseData) {
          final order = Order.fromJson(element);
          orderlist.add(order);
        }
        return orderlist;
      } else {
        throw Exception(
            'Failed to retrieve orders: ${jsonDecode(response.body)['message']}');
      }
    } catch (e) {
      throw Exception('Error getting orders: $e');
    }
  }

  Future<int> approveOrder(int orderId) async {
    final authToken = await getToken();
    final apiUrl =
        'http://crocs.crocsclub.shop/admin/order/status?order_id=$orderId';
    final headers = {
      'accept': 'application/json',
      'Authorization': authToken ?? '',
    };
    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        print('Order $orderId approved successfully');
        return 200;
      } else {
        final responseBody = jsonDecode(response.body);
        if (responseBody['error'] ==
            "cannot approve this order because it's in a processed or canceled state") {
          print('Order $orderId already approved or processed');
          return 201;
        } else {
          return response.statusCode;
        }
      }
    } catch (e) {
      throw Exception('Error approving order: $e');
    }
  }
}
