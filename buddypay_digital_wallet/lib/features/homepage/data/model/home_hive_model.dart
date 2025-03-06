import 'package:hive/hive.dart';

part 'home_hive_model.g.dart';

@HiveType(typeId: 0)
class HomeHiveModel {
  @HiveField(0)
  final int balance;
  @HiveField(1)
  final List<dynamic> statements;

  HomeHiveModel({required this.balance, required this.statements});

  factory HomeHiveModel.fromJson(Map<String, dynamic> json) {
    return HomeHiveModel(
      balance: json['balance'],
      statements: json['statements'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'statements': statements,
    };
  }
}
