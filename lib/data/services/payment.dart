import 'dart:convert';
import 'package:crocsclub_admin/domain/models/payment_model.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:http/http.dart' as http;

class PaymentServices {
  Future<int> addPaymentMethod(String paymentMethodName) async {
    final authToken = await getToken();
    const String apiUrl = 'http://crocs.crocsclub.shop/admin/payment-method/pay';
    final Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': authToken ?? '',
      'Content-Type': 'application/json',
    };

    final Map<String, String> body = {
      'payment_method': paymentMethodName,
    };

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        print('Payment method added successfully');
        return response.statusCode;
      } else {
        print('Failed to add payment method: ${response.reasonPhrase}');
        return response.statusCode;
      }
    } catch (e) {
      print('Error adding payment method: $e');
      throw Exception('Error adding payment method: $e');
    }
  }

  Future<List<PaymentMethod>> getPaymentMethods() async {
    const String apiUrl = 'http://crocs.crocsclub.shop/admin/payment-method';
    final authToken = await getToken();
    final Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': authToken ?? '',
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body)['data'];
        return responseData
            .map((data) => PaymentMethod.fromJson(data))
            .toList();
      } else {
        throw Exception(
            'Failed to get payment methods: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error getting payment methods: $e');
    }
  }

  Future<int> deletePaymentMethod(int paymentMethodId) async {
    final authToken =
        await getToken(); // Assuming getToken() fetches your auth token
    const String apiUrl =
        'http://crocs.crocsclub.shop/admin/payment-method'; // Assuming this is the correct URL
    final Uri url = Uri.parse(
        '$apiUrl?id=$paymentMethodId'); // Construct URL with query parameter

    final Map<String, String> headers = {
      'accept': 'application/json',
      'Authorization': authToken ?? '',
    };

    try {
      final response = await http.delete(url, headers: headers);
      if (response.statusCode == 200) {
        print('succesfully deleted payment method');
        return response.statusCode;
      } else {
        print('couldnt deleted payment method');

        return response.statusCode;
      }
    } catch (e) {
      print('Error deleting payment method: $e');
      throw Exception('Error deleting payment method: $e');
    }
  }
}
