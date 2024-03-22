class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final bool blockStatus;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.blockStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      blockStatus: json['block_status'],
    );
  }
}
