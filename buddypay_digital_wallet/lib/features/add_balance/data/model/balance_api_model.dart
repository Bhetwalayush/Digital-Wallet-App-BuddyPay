import 'package:buddypay_digital_wallet/features/add_balance/domain/entity/balance_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'balance_api_model.g.dart';

@JsonSerializable()
class RechargeModel extends RechargeEntity {
  const RechargeModel({
    required super.code,
  });

  factory RechargeModel.fromJson(Map<String, dynamic> json) =>
      _$RechargeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RechargeModelToJson(this);
}
