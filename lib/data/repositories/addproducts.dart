import 'package:crocsclub_admin/data/models/product.dart';
import 'package:crocsclub_admin/utils/functions/functions.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<Response<dynamic>> addProduct(Product product) async {
    final dio = Dio();
    final token = await getToken();
    dio.options.headers['Authorization'] = 'Bearer $token';

    final formData = FormData.fromMap({
      'category_id': product.categoryId,
      'product_name': product.productName,
      'size': product.size,
      'stock': product.stock,
      'price': product.price,
      if (product.image != null)
        'image': await MultipartFile.fromFile(product.image!.path),
    });

    try {
      final response = await dio.post(
        'http://10.0.2.2:8080/admin/inventories',
        data: formData,
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
      return response;
    } on DioException catch (error) {
      throw Exception('Error adding product: ${error.message}');
    }
  }

  // Future<List<Product>> fetchProducts() async {
  //   final response = await http.get(Uri.parse(apiUrl));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     return data.map((json) => Product.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load products');
  //   }
  // }
}
