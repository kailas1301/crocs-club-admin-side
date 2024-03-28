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