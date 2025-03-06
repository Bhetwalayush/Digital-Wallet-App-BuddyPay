import 'package:buddypay_digital_wallet/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPrefs {
  final SharedPreferences _sharedPreferences;

  UserSharedPrefs(this._sharedPreferences);

  // Save user data (name, balance, id, and admin status)
  Future<Either<Failure, void>> saveUserData(String token, String fullname,
      String phone, int balance, String id, String image, bool isAdmin) async {
    try {
      await Future.wait([
        _sharedPreferences.setString('userToken', token),
        _sharedPreferences.setString('userName', fullname),
        _sharedPreferences.setString('userPhone', phone),
        _sharedPreferences.setInt('userBalance', balance),
        _sharedPreferences.setString('userId', id),
        _sharedPreferences.setString('image', image),
        _sharedPreferences.setBool('isAdmin', isAdmin),
      ]);
      printStoredData();

      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Print stored user data
  Future<void> printStoredData() async {
    final tokenResult = await getUserToken();
    final userNameResult = await getUserName();
    final userPhoneResult = await getPhone();
    final userBalanceResult = await getUserBalance();
    final userIdResult = await getUserId();
    final image = await getImage();
    final isAdminResult = await getIsAdmin();

    tokenResult.fold(
      (failure) => print('Error getting user name: ${failure.message}'),
      (userToken) => print('Stored user token: $userToken'),
    );

    userNameResult.fold(
      (failure) => print('Error getting user name: ${failure.message}'),
      (userName) => print('Stored user name: $userName'),
    );
    userPhoneResult.fold(
      (failure) => print('Error getting user phone: ${failure.message}'),
      (userPhone) => print('Stored user name: $userPhone'),
    );

    userBalanceResult.fold(
      (failure) => print('Error getting user balance: ${failure.message}'),
      (balance) => print('Stored user balance: $balance'),
    );

    userIdResult.fold(
      (failure) => print('Error getting user ID: ${failure.message}'),
      (userId) => print('Stored user ID: $userId'),
    );

    isAdminResult.fold(
      (failure) => print('Error getting admin status: ${failure.message}'),
      (isAdmin) => print('Stored admin status: $isAdmin'),
    );
  }

  // Retrieve user token
  Future<Either<Failure, String?>> getUserToken() async {
    try {
      final userToken = _sharedPreferences.getString('userToken');
      return Right(userToken);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Retrieve user name
  Future<Either<Failure, String?>> getUserName() async {
    try {
      final userName = _sharedPreferences.getString('userName');
      return Right(userName);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Retrieve user name
  Future<Either<Failure, String?>> getPhone() async {
    try {
      final userPhone = _sharedPreferences.getString('userPhone');
      return Right(userPhone);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Retrieve user balance
  Future<Either<Failure, int?>> getUserBalance() async {
    try {
      final balance = _sharedPreferences.getInt('userBalance');
      return Right(balance);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, String?>> getImage() async {
    try {
      final image = _sharedPreferences.getString('image');
      return Right(image);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Retrieve user ID
  Future<Either<Failure, String?>> getUserId() async {
    try {
      final userId = _sharedPreferences.getString('userId');
      return Right(userId);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Retrieve admin status
  Future<Either<Failure, bool?>> getIsAdmin() async {
    try {
      final isAdmin = _sharedPreferences.getBool('isAdmin');
      return Right(isAdmin);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  // Clear user data
  Future<Either<Failure, void>> clearUserData() async {
    try {
      await Future.wait([
        _sharedPreferences.remove('userToken'),
        _sharedPreferences.remove('userName'),
        _sharedPreferences.remove('userPhone'),
        _sharedPreferences.remove('userBalance'),
        _sharedPreferences.remove('userId'),
        _sharedPreferences.remove('image'),
        _sharedPreferences.remove('isAdmin'),
      ]);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
