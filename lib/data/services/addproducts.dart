import 'package:crocsclub_admin/domain/models/product.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:dio/dio.dart';

class ProductService {
  final Dio dio = Dio(); // Create a single instance for efficiency

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

  Future<List<ProductFromApi>> getProducts() async {
    try {
      final dio = Dio();
      final response = await dio.get('http://10.0.2.2:8080/admin/inventories');

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        if (responseData['error'] == null) {
          final productList = responseData['data'] as List<dynamic>;
          return productList
              .map((productData) => ProductFromApi.fromJson(productData))
              .toList();
        } else {
          throw Exception('API error: ${responseData['error']}');
        }
      } else {
        throw Exception(
            'API request failed with status code: ${response.statusCode}');
      }
    } on DioException catch (error) {
      throw Exception('Error fetching products: ${error.message}');
    } catch (error) {
      throw Exception('Unexpected error: $error');
    }
  }
}