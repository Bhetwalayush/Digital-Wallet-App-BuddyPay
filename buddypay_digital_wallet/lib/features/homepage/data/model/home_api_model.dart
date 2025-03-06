import 'package:json_annotation/json_annotation.dart';

part 'home_api_model.g.dart';

@JsonSerializable()
class HomeApiModel {
  final int balance;
  final List<Map<String, dynamic>> statements;

  HomeApiModel({required this.balance, required this.statements});

  factory HomeApiModel.fromJson(Map<String, dynamic> json) =>
      _$HomeApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeApiModelToJson(this);
}
