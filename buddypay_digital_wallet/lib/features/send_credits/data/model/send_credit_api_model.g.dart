// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_credit_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendCreditModel _$SendCreditModelFromJson(Map<String, dynamic> json) =>
    SendCreditModel(
      recipientNumber: json['recipientNumber'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$SendCreditModelToJson(SendCreditModel instance) =>
    <String, dynamic>{
      'recipientNumber': instance.recipientNumber,
      'amount': instance.amount,
    };
