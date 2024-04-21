class Order {
  final String orderId;
  final double finalPrice;
  final String paymentStatus;
  final String name;
  final String email;
  final String phone;
  final String houseName;
  final String state;
  final String pin;
  final String street;
  final String city;

  Order({
    required this.orderId,
    required this.finalPrice,
    required this.paymentStatus,
    required this.name,
    required this.email,
    required this.phone,
    required this.houseName,
    required this.state,
    required this.pin,
    required this.street,
    required this.city,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      finalPrice: json['final_price'],
      paymentStatus: json['payment_status'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      houseName: json['house_name'],
      state: json['state'],
      pin: json['pin'],
      street: json['street'],
      city: json['city'],
    );
  }
}