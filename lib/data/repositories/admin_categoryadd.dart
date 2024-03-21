import 'dart:convert';
import 'dart:io';
import 'package:crocsclub_admin/presentation/splash_screen/splash_screen.dart';
import 'package:http/http.dart' as http;

class AdminCategoryRepo {
  final String baseUrl = 'http://10.0.2.2:8080/admin/category';
  final HttpClient client = HttpClient();

  Future<String> addCategory(String name) async {
    String? token = await getToken();
    print('The token is $token');
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'category': name}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('succesfully added category:');

        return 'success';
      } else {
        print('could not added category: ${response.statusCode}');
        return 'Error adding category (Status Code: ${response.statusCode})';
      }
    } catch (e) {
      throw Exception('Failed to add category: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    String? token = await getToken(); // Replace with secure token retrieval
    final url = Uri.parse(baseUrl);
    print('The token is $token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // Add space after Bearer
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Decode the JSON response as a Map (assuming it's a structured object)
        final body = jsonDecode(response.body);

        final data = body['data'];

        print('The category is fetched');
        // Extract the list of categories from the Map, assuming they're under a "data" key
        List<Map<String, dynamic>> list = [];
        for (var i = 0; i < data.length; i++) {
          final dataAtIndex = data[i];
          // final categoryname = dataAtIndex['category'];

          list.add(dataAtIndex);
        }

        return list;
      } else {
        throw Exception('Failed to get categories: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to get categories: $e');
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    print('categoryid is $categoryId');
    final url = Uri.parse('http://10.0.2.2:8080/admin/category?id=$categoryId');
    String? token = await getToken();

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // Add space after Bearer
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Category with ID $categoryId deleted successfully!');
      } else {
        throw Exception('Failed to delete category: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting category: $e');
      // Handle errors appropriately (e.g., display an error message to the user)
    }
  }

  Future<void> editCategory(String id, String newName) async {
    String? token = await getToken();
    final url = Uri.parse(baseUrl);

    // Prepare the request body with current and new names
    final body = jsonEncode({
      'current': id, // Assuming 'id' represents the current name
      'new': newName,
    });

    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token', // Add space after Bearer
        },
        body: body,
      );

      if (response.statusCode == 200) {
        print('Category with ID $id updated successfully!');
        // Handle successful update (e.g., display a confirmation message)
      } else {
        throw Exception('Failed to update category: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating category: $e');
      // Handle errors appropriately (e.g., display an error message to the user)
    }
  }
}
