// Model class for a coupon
class Coupon {
  final int id;
  final String name;
  final int discountPercentage;
  final bool isAvailable;
  final int minimumPrice;

  Coupon({
    required this.id,
    required this.name,
    required this.discountPercentage,
    required this.isAvailable,
    required this.minimumPrice,
  });

  // Convert Coupon object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'discount_percentage': discountPercentage,
      'is_available': isAvailable,
      'minimum_price': minimumPrice,
    };
  }

  // Create Coupon object from JSON
  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'],
      name: json['name'],
      isAvailable: json['available'],
      discountPercentage: json['discount_percentage'],
      minimumPrice: json['minimum_price'],
    );
  }
}
