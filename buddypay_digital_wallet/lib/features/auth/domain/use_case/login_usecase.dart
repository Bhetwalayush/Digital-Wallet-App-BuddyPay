import 'package:buddypay_digital_wallet/app/shared_prefs/token_shared_prefs.dart';
import 'package:buddypay_digital_wallet/app/usecase/usecase.dart';
import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String phone;
  final String password;

  const LoginParams({
    required this.phone,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : phone = '',
        password = '';

  @override
  List<Object> get props => [phone, password];
}

class LoginUseCase implements UsecaseWithParams<String, LoginParams> {
  final IAuthRepository repository;
  final TokenSharedPrefs tokenSharedPrefs;

  LoginUseCase(this.repository, this.tokenSharedPrefs);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    // IF api then store token in shared preferences
    return repository.loginUser(params.phone, params.password).then((value) {
      return value.fold(
        (failure) => Left(failure),
        (token) {
          tokenSharedPrefs.saveToken(token);
          // tokenSharedPrefs.getToken().then((value) {
          //   print(value);
          // });
          return Right(token);
        },
      );
    });
  }
}
