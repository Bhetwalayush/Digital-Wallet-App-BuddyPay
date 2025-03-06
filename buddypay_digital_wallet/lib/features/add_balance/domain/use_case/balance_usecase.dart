import 'package:buddypay_digital_wallet/app/usecase/usecase.dart';
import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/add_balance/domain/repository/balance_repository.dart';
import 'package:dartz/dartz.dart';

class RechargeParams {
  final String code;

  RechargeParams({
    required this.code,
  });
}

class RechargeUseCase implements UsecaseWithParams<String, RechargeParams> {
  final IRechargeRepository repository;

  RechargeUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(RechargeParams params) async {
    // Await the result from the repository
    final result = await repository.recharge(
      params.code,
    );

    // Return the result directly, handling the failure and success cases
    return result.fold(
      (failure) => Left(failure), // Return failure if any
      (successMessage) =>
          Right(successMessage), // Assuming successMessage is a String
    );
  }
}
