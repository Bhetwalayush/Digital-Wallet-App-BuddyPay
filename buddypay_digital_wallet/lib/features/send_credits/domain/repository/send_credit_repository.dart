import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ISendCreditRepository {
  Future<Either<Failure, String>> sendCredit(
      String recipientNumber, double amount);
}
