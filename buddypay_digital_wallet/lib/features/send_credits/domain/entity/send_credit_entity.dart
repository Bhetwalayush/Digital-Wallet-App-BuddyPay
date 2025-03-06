import 'package:equatable/equatable.dart';

class SendCreditEntity extends Equatable {
  final String recipientNumber;
  final double amount;

  const SendCreditEntity({
    required this.recipientNumber,
    required this.amount,
  });

  @override
  List<Object> get props => [recipientNumber, amount];
}
