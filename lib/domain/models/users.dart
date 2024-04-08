class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final bool blocked;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.blocked,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      blocked: json['blocked'],
    );
  }
}
