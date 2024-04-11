import 'dart:convert';
import 'package:crocsclub_admin/domain/models/coupon.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:http/http.dart' as http;

class CouponServices {
//
// Your addCoupon function
  Future<String> addCoupon(Coupon coupon) async {
    print('ADD coupon function was called');
    const url = 'http://10.0.2.2:8080/admin/coupon';
    final token = await getToken();
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include authentication token
      },
      body: jsonEncode(coupon.toJson()),
    );

    if (response.statusCode == 200) {
      print('added succesfully');
      return 'Coupon added successfully';
    } else {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['error'];
      if (errorMessage == 'coupon already exist') {
        print('coupon already exist ${responseBody['error']}');

        return 'Coupon already exists';
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['error'];
        print('error while adding coupon ${responseBody['error']}');
        if (errorMessage != null) {
          return errorMessage;
        } else {
          return 'Cannot add coupon';
        }
      }
    }
  }

// Function to retrieve all coupons
  Future<List<Coupon>> getAllCoupons() async {
    const url = 'http://10.0.2.2:8080/admin/coupon';
    final token = await getToken();
    final response = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Authorization': 'Bearer $token', // Include authentication token
      },
    );
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body)['data'];

      final List<Coupon> couponList = [];
      for (var map in jsonList) {
        final coupon = Coupon.fromJson(map);
        couponList.add(coupon);
      }
      return couponList;
    } else {
      throw Exception('Failed to get coupons');
    }
  }

  // Your updateCoupon function
  Future<String> updateCoupon(Coupon coupon) async {
    const url = 'http://10.0.2.2:8080/admin/coupon';
    final token = await getToken();
    final response = await http.patch(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Include authentication token
      },
      body: jsonEncode(coupon.toJson()),
    );
    final statusCode = response.statusCode;

    if (statusCode == 200) {
      return 'Successfully edited coupon';
    } else {
      return ' Cannot edit coupon';
    }
  }
}
