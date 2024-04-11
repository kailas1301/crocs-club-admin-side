class CategoryOffer {
  final int? id;
  final int categoryId;
  final int discountPercentage;
  final String offerName;

  CategoryOffer({
    this.id,
    required this.categoryId,
    required this.discountPercentage,
    required this.offerName,
  });

  // Convert CategoryOffer object to JSON
  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryId,
      'discount_percentage': discountPercentage,
      'offer_name': offerName,
    };
  }

  // Create CategoryOffer object from JSON
  factory CategoryOffer.fromJson(Map<String, dynamic> json) {
    return CategoryOffer(
      id: json['id'],
      categoryId: json['category_id'],
      discountPercentage: json['discount_percentage'],
      offerName: json['offer_name'],
    );
  }
}
