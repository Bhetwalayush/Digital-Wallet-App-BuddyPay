import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/send_credits/data/data_source/send_credit_datasourse.dart';
import 'package:buddypay_digital_wallet/features/send_credits/domain/repository/send_credit_repository.dart';
import 'package:dartz/dartz.dart';

class SendCreditRepositoryImpl implements ISendCreditRepository {
  final ISendCreditRemoteDataSource remoteDataSource;

  SendCreditRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> sendCredit(
      String recipientNumber, double amount) async {
    try {
      final result = await remoteDataSource.sendCredit(recipientNumber, amount);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
