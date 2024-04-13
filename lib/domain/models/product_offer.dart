class ProductOfferModel {
  final int? id;
  final int productId;
  final int discountPercentage;
  final String offerName;

  ProductOfferModel({
    this.id,
    required this.productId,
    required this.discountPercentage,
    required this.offerName,
  });

  // Convert CategoryOffer object to JSON
  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'discount_percentage': discountPercentage,
      'offer_name': offerName,
    };
  }

  // Create CategoryOffer object from JSON
  factory ProductOfferModel.fromJson(Map<String, dynamic> json) {
    return ProductOfferModel(
      id: json['id'],
      productId: json['product_id'],
      discountPercentage: json['discount_percentage'],
      offerName: json['offer_name'],
    );
  }
}
