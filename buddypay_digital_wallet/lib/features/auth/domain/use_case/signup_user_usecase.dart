import 'package:buddypay_digital_wallet/app/usecase/usecase.dart';
import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String fullname;
  final String phone;
  final String password;
  final String pin;
  final String device;
  final String? image;

  const RegisterUserParams({
    required this.fullname,
    required this.phone,
    required this.password,
    required this.pin,
    this.device = "mobile",
    this.image,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.fullname,
    required this.phone,
    required this.password,
    required this.pin,
    required this.device,
    this.image,
  });

  @override
  List<Object?> get props => [fullname, phone, password, pin, device];
}

class RegisterUseCase implements UsecaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final authEntity = AuthEntity(
      fullname: params.fullname,
      phone: params.phone,
      password: params.password,
      pin: params.pin,
      device: params.device,
      image: params.image,
    );
    return repository.registerUser(authEntity);
  }
}
