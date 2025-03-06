import 'dart:io';

import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity user);

  Future<Either<Failure, String>> loginUser(String phone, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, AuthEntity>> getCurrentUser();
}
