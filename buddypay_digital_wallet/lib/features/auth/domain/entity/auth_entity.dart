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

  @override
  List<Object?> get props =>
      [userId, fullname, phone, image, password, pin, device];
}
