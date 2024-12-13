class SignupModel {
  final String fullName;
  final String phone;
  final String password;
  final String pin;
  final String device;

  SignupModel({
    required this.fullName,
    required this.phone,
    required this.password,
    required this.pin,
    this.device = "mobile",
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullName,
      'phone': phone,
      'password': password,
      'pin': pin,
      'device': device,
    };
  }
}
