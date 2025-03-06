import 'package:buddypay_digital_wallet/features/send_credits/domain/entity/send_credit_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'send_credit_api_model.g.dart';

@JsonSerializable()
class SendCreditModel extends SendCreditEntity {
  const SendCreditModel({
    required super.recipientNumber,
    required super.amount,
  });

  factory SendCreditModel.fromJson(Map<String, dynamic> json) =>
      _$SendCreditModelFromJson(json);

  Map<String, dynamic> toJson() => _$SendCreditModelToJson(this);
}
