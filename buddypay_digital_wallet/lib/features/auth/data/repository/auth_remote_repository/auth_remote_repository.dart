import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:buddypay_digital_wallet/features/auth/data/data_source/auth_remote_datasource/auth_local_datasource.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String phone, String password) async {
    try {
      // Call the remote data source to handle the login API call
      final token = await _authRemoteDataSource.loginUser(phone, password);
      return Right(token);
    } catch (e) {
      // If an error occurs, wrap it in a Failure and return as Left
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      await _authRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
