class User {
  final String phone;
  final String password;

  User({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}
