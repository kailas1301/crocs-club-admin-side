class ProductOffer {
  final int? id;
  final int categoryId;
  final int discountPercentage;
  final String offerName;

  ProductOffer({
    this.id,
    required this.categoryId,
    required this.discountPercentage,
    required this.offerName,
  });

  // Convert CategoryOffer object to JSON
  Map<String, dynamic> toJson() {
    return {
      'product_id': categoryId,
      'discount_percentage': discountPercentage,
      'offer_name': offerName,
    };
  }

  // Create CategoryOffer object from JSON
  factory ProductOffer.fromJson(Map<String, dynamic> json) {
    return ProductOffer(
      id: json['id'],
      categoryId: json['product_id'],
      discountPercentage: json['discount_percentage'],
      offerName: json['offer_name'],
    );
  }
}
