import 'dart:io';

class Product {
  final int categoryId;
  final String productName;
  final String size;
  final int stock;
  final double price;
  final File? image;

  Product({
    required this.categoryId,
    required this.productName,
    required this.size,
    required this.stock,
    required this.price,
    this.image,
  });
}

class ProductFromApi {
  final int id;
  final String categoryId;
  final String productName;
  final String size;
  final int stock;
  final double price;
  final List<String> image;

  ProductFromApi({
    required this.id,
    required this.categoryId,
    required this.productName,
    required this.size,
    required this.stock,
    required this.price,
    required this.image,
  });

  factory ProductFromApi.fromJson(Map<String, dynamic> json) => ProductFromApi(
        id: json['id'] as int,
        categoryId: json['category_id'] as String,
        productName: json['product_name'] as String,
        size: json['size'] as String,
        stock: json['stock'] as int,
        price: json['price'].toDouble(), // Assuming price is a double
        image: List<String>.from(json['image']),
      );
}
