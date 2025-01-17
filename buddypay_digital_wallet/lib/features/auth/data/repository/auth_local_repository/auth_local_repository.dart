import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/auth/data/data_source/auth_local_datasource/auth_local_datasource.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await _authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String phone, String password) async {
    try {
      final token = await _authLocalDataSource.loginUser(phone, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authLocalDataSource
          .registerUser(user); // Ensure async handling here
      return const Right(null); // Returning void, so null is returned
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
