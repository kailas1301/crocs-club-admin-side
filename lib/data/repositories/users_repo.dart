import 'dart:convert';
import 'package:crocsclub_admin/presentation/splash_screen/splash_screen.dart';
import 'package:http/http.dart' as http;
import 'package:crocsclub_admin/data/models/users.dart';

class UsersRepository {
  String baseUrl = 'http://10.0.2.2:8080/admin/users?page=1';

  Future<List<User>> fetchUsers() async {
    final token = await getToken();
    final url = Uri.parse(baseUrl);
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      print('Successfully fetched users: ${response.statusCode}');
      final data = jsonDecode(response.body);
      final userList = (data['data'] as List<dynamic>)
          .map((userData) => User.fromJson(userData))
          .toList();
      return userList;
    } else {
      print('Failed to fetch users: ${response.statusCode}');
      throw Exception('Failed to fetch users: ${response.statusCode}');
    }
  }
}
