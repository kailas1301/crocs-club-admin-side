class PaymentMethod {
  final int id;
  final String paymentName;
  final bool isDeleted;

  PaymentMethod({
    required this.id,
    required this.paymentName,
    required this.isDeleted,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      id: json['ID'],
      paymentName: json['payment_name'],
      isDeleted: json['is_deleted'],
    );
  }
}
