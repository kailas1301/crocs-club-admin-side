import 'dart:convert';
import 'package:crocsclub_admin/domain/models/order.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  Future<List<Order>> getAllOrders(int page) async {
    final authToken = await getToken();
    final apiUrl = 'http://10.0.2.2:8080/admin/order/get?page=$page';
    final headers = {
      'accept': 'application/json',
      'Authorization': authToken ?? '',
    };
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['data'];
        return responseData.map((data) => Order.fromJson(data)).toList();
      } else {
        throw Exception(
            'Failed to retrieve orders: ${jsonDecode(response.body)['message']}');
      }
    } catch (e) {
      throw Exception('Error getting orders: $e');
    }
  }

  Future<String> approveOrder(int orderId) async {
  final authToken = await getToken();
  final apiUrl = 'http://10.0.2.2:8080/admin/order/status?order_id=$orderId';
  final headers = {
    'accept': 'application/json',
    'Authorization': authToken ?? '',
  };
  try {
    final response = await http.post(Uri.parse(apiUrl), headers: headers);
    if (response.statusCode == 200) {
      print('Order $orderId approved successfully');
      return "success";
    } else {
      final responseBody = jsonDecode(response.body);
      if (responseBody['error'] ==
          "cannot approve this order because it's in a processed or canceled state") {
        print('Order $orderId already approved or processed');
        return "already_approved";
      } else {
        return 'error';
      }
    }
  } catch (e) {
    throw Exception('Error approving order: $e');
  }
}
}
