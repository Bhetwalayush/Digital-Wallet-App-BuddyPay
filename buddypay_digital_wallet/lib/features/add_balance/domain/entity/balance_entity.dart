import 'package:equatable/equatable.dart';

class RechargeEntity extends Equatable {
  final String code;

  const RechargeEntity({
    required this.code,
  });

  @override
  List<Object> get props => [code];
}
