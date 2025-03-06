import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/add_balance/data/data_source/balance_datasourse.dart';
import 'package:buddypay_digital_wallet/features/add_balance/domain/repository/balance_repository.dart';
import 'package:dartz/dartz.dart';

class RechargeRepositoryImpl implements IRechargeRepository {
  final IRechargeRemoteDataSource remoteDataSource;

  RechargeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> recharge(String code) async {
    try {
      final result = await remoteDataSource.recharge(code);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
