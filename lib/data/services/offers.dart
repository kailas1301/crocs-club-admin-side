import 'dart:convert';
import 'package:crocsclub_admin/domain/models/category_offer.dart';
import 'package:crocsclub_admin/domain/models/product_offerModel.dart';
import 'package:http/http.dart' as http;
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';

class OfferServices {
  static const String baseUrl = 'http://10.0.2.2:8080/admin';
  static const String categoryOfferEndpoint = '/offer/category-offer';
  static const String getCategoryOfferEndpoint = '/offer/get-category-offer';
  static const String expireCategoryOfferEndpoint =
      '/offer/expire-category-offer';
  static const String productOfferEndpoint = '/offer/product-offer';
  static const String getProductOfferEndpoint = '/offer/get-product-offer';
  static const String expireProductOfferEndpoint =
      '/offer/expire-product-offer';

  Future<String> addCategoryOffer(CategoryOffer categoryOffer) async {
    print('addCategoryOffer function was called');

    final url = Uri.parse('$baseUrl$categoryOfferEndpoint');
    final token = await getToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(categoryOffer.toJson()),
    );

    if (response.statusCode == 201) {
      print('Category offer added successfully');
      return 'offer added successfully';
    } else if (response.statusCode == 400) {
      print('Category offer was not added successfully');
      return 'error'; // Bad request
    } else if (response.statusCode == 500) {
      print('Category offer was not added successfully');
      return 'offer already exists'; // Internal server error
    } else {
      print('Category offer was not added successfully');
      return 'error'; // Other errors
    }
  }

  Future<List<CategoryOffer>> getAllCategoryOffers() async {
    final url = Uri.parse('$baseUrl$getCategoryOfferEndpoint');
    final token = await getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body)['data'];

      final List<CategoryOffer> categoryOffers = [];
      for (var map in jsonList) {
        final categoryOffer = CategoryOffer.fromJson(map);
        categoryOffers.add(categoryOffer);
      }
      return categoryOffers;
    } else if (response.statusCode == 400) {
      print('Invalid request format or fields provided in the wrong format');
      throw Exception(
          'Invalid request format or fields provided in the wrong format');
    } else if (response.statusCode == 500) {
      print('Failed to retrieve category offers');
      throw Exception('Failed to retrieve category offers');
    } else {
      print('Unexpected status code: ${response.statusCode}');
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  }

  Future<String> deleteCategoryOffer(int id) async {
    final url = Uri.parse('$baseUrl$expireCategoryOfferEndpoint?id=$id');
    final token = await getToken();
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Successfully made category offer invalid of id $id');
      return 'success';
    } else if (response.statusCode == 400) {
      print('Invalid request format or fields provided in the wrong format');
      throw Exception(
          'Invalid request format or fields provided in the wrong format');
    } else if (response.statusCode == 500) {
      print('Failed to expire category offer');
      throw Exception('Failed to expire category offer');
    } else {
      print('Unexpected status code: ${response.statusCode}');
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  }

  Future<String> addProductOffer(ProductOffer productOffer) async {
    print('addCategoryOffer function was called');

    final url = Uri.parse('$baseUrl$productOfferEndpoint');
    final token = await getToken();
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(productOffer.toJson()),
    );

    if (response.statusCode == 201) {
      print('Category offer added successfully');
      return 'offer added successfully';
    } else if (response.statusCode == 400) {
      print('Category offer was not added successfully');
      return 'error'; // Bad request
    } else if (response.statusCode == 500) {
      print('Category offer was not added successfully');
      return 'offer already exists'; // Internal server error
    } else {
      print('Category offer was not added successfully');
      return 'error'; // Other errors
    }
  }

  Future<List<ProductOffer>> getAllProductOffers() async {
    final url = Uri.parse('$baseUrl$getProductOfferEndpoint');
    final token = await getToken();
    final response = await http.get(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonList = json.decode(response.body)['data'];

      final List<ProductOffer> productOfferS = [];
      for (var map in jsonList) {
        final productOffer = ProductOffer.fromJson(map);
        productOfferS.add(productOffer);
      }
      return productOfferS;
    } else if (response.statusCode == 400) {
      print('Invalid request format or fields provided in the wrong format');
      throw Exception(
          'Invalid request format or fields provided in the wrong format');
    } else if (response.statusCode == 500) {
      print('Failed to retrieve offers');
      throw Exception('Failed to retrieve category offers');
    } else {
      print('Unexpected status code: ${response.statusCode}');
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  }

  Future<String> deleteProductOffer(int id) async {
    final url = Uri.parse('$baseUrl$expireProductOfferEndpoint?id=$id');
    final token = await getToken();
    final response = await http.delete(
      url,
      headers: <String, String>{
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Successfully made Product offer invalid of id $id');
      return 'success';
    } else if (response.statusCode == 400) {
      print('Invalid request format or fields provided in the wrong format');
      throw Exception(
          'Invalid request format or fields provided in the wrong format');
    } else if (response.statusCode == 500) {
      print('Failed to expire Product offer');
      throw Exception('Failed to expire category offer');
    } else {
      print('Unexpected status code: ${response.statusCode}');
      throw Exception('Unexpected status code: ${response.statusCode}');
    }
  }
}
