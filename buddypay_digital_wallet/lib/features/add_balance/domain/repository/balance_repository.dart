import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IRechargeRepository {
  Future<Either<Failure, String>> recharge(String code);
}
