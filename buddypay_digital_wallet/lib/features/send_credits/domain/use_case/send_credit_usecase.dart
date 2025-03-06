import 'package:buddypay_digital_wallet/app/usecase/usecase.dart';
import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/send_credits/domain/repository/send_credit_repository.dart';
import 'package:dartz/dartz.dart';

class SendCreditParams {
  final String recipientNumber;
  final double amount;

  SendCreditParams({
    required this.recipientNumber,
    required this.amount,
  });
}

class SendCreditUseCase implements UsecaseWithParams<String, SendCreditParams> {
  final ISendCreditRepository repository;

  SendCreditUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(SendCreditParams params) async {
    // Await the result from the repository
    final result = await repository.sendCredit(
      params.recipientNumber,
      params.amount,
    );

    // Return the result directly, handling the failure and success cases
    return result.fold(
      (failure) => Left(failure), // Return failure if any
      (successMessage) =>
          Right(successMessage), // Assuming successMessage is a String
    );
  }
}
