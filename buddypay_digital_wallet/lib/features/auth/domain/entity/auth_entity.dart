import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String fullname;
  final String phone;
  final String? image;
  final String password;
  final String pin;
  final String device;

  const AuthEntity({
    this.userId,
    required this.fullname,
    required this.phone,
    this.image,
    this.device = "mobile",
    required this.pin,
    required this.password,
  });
  // Define fromJson method to parse the response from API
  // factory AuthEntity.fromJson(Map<String, dynamic> json) {
  //   return AuthEntity(
  //     userId: json['userId'],
  //     fullname: json['fullname'],
  //     phone: json['phone'],
  //     image: json['image'],
  //     password: json['password'],
  //     pin: json['pin'],
  //     device: json['device'] ??
  //         "mobile",
  //   );
  // }

  @override
  List<Object?> get props =>
      [userId, fullname, phone, image, password, pin, device];
}
