import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String fullname;
  final String phone;
  final String? password;
  final String pin;
  final String? image;
  final String device;

  const AuthApiModel({
    this.id,
    required this.fullname,
    required this.phone,
    required this.password,
    required this.pin,
    required this.image,
    required this.device,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  //To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      fullname: fullname,
      phone: phone,
      password: password ?? '',
      pin: pin,
      image: image,
      device: device,
    );
  }

  //From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      fullname: entity.fullname,
      phone: entity.phone,
      password: entity.password,
      pin: entity.pin,
      image: entity.image,
      device: entity.device,
    );
  }

  @override
  List<Object?> get props =>
      [id, fullname, image, phone, pin, device, password];
}
