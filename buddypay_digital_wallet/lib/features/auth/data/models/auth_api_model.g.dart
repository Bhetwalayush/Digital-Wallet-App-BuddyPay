// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      fullname: json['fullname'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String?,
      pin: json['pin'] as String,
      image: json['image'] as String?,
      device: json['device'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fullname': instance.fullname,
      'phone': instance.phone,
      'password': instance.password,
      'pin': instance.pin,
      'image': instance.image,
      'device': instance.device,
    };
