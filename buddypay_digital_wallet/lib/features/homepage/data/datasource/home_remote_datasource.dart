import 'package:buddypay_digital_wallet/app/constants/api_endpoints.dart';
import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:dio/dio.dart';

class HomeRemoteDatasource {
  final Dio _dio;
  final UserSharedPrefs _tokenSharedPrefs;

  HomeRemoteDatasource(this._dio, this._tokenSharedPrefs);

  Future<int> fetchBalance() async {
    try {
      final tokenOrRight = await _tokenSharedPrefs.getUserToken();
      // Unwrap token
      final token = tokenOrRight.fold(
        (failure) => '',
        (token) => token,
      );

      // if (token.isEmpty) {
      //   throw Exception("No token found");
      // }

      Response response = await _dio.get(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.balance}",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      if (response.statusCode == 200) {
        return response.data["balance"] as int;
      } else {
        throw Exception("Failed to fetch balance");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data['message'] ?? e.message}");
    } catch (e) {
      throw Exception("Error fetching balance: $e");
    }
  }

  Future<List<Map<String, dynamic>>> fetchStatement() async {
    try {
      final tokenOrRight = await _tokenSharedPrefs.getUserToken();
      // Unwrap token
      final token = tokenOrRight.fold(
        (failure) => '',
        (token) => token,
      );
      final senderIdOrRight =
          await _tokenSharedPrefs.getUserId(); // Get Either<Failure, String>

      // Unwrap the senderId from the Right value
      final userId = senderIdOrRight.fold(
        (failure) => '', // Handle the error case if the senderId is in Left
        (id) => id, // Extract the value if it is in Right
      );
      // if (token.isEmpty) {
      //   throw Exception("No token found");
      // }

      Response response = await _dio.get(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.fetchstatement}$userId",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> statements = response.data["statements"];

        // Take the most recent 3 statements
        List<Map<String, dynamic>> recentStatements = statements
            .take(3)
            .map((s) => Map<String, dynamic>.from(s))
            .toList();

        return recentStatements;
      } else {
        throw Exception("Failed to fetch balance");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data['message'] ?? e.message}");
    } catch (e) {
      throw Exception("Error fetching balance: $e");
    }
  }

  Future<List<dynamic>> fetchAllStatement() async {
    try {
      final tokenOrRight = await _tokenSharedPrefs.getUserToken();
      // Unwrap token
      final token = tokenOrRight.fold(
        (failure) => '',
        (token) => token,
      );
      final senderIdOrRight =
          await _tokenSharedPrefs.getUserId(); // Get Either<Failure, String>

      // Unwrap the senderId from the Right value
      final userId = senderIdOrRight.fold(
        (failure) => '', // Handle the error case if the senderId is in Left
        (id) => id, // Extract the value if it is in Right
      );
      // if (token.isEmpty) {
      //   throw Exception("No token found");
      // }

      Response response = await _dio.get(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.fetchstatement}$userId",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      if (response.statusCode == 200) {
        List<dynamic> statements = response.data["statements"];

        // Take the most recent 3 statements

        return statements;
      } else {
        throw Exception("Failed to fetch balance");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data['message'] ?? e.message}");
    } catch (e) {
      throw Exception("Error fetching balance: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getUserDetail() async {
    try {
      final tokenOrRight = await _tokenSharedPrefs.getUserToken();
      final token = tokenOrRight.fold(
        (failure) => '',
        (token) => token,
      );
      final senderIdOrRight =
          await _tokenSharedPrefs.getUserId(); // Get Either<Failure, String>

      // Unwrap the senderId from the Right value
      final userId = senderIdOrRight.fold(
        (failure) => '', // Handle the error case if the senderId is in Left
        (id) => id, // Extract the value if it is in Right
      );
      Response response = await _dio.get(
        "${ApiEndpoints.baseUrl}${ApiEndpoints.getUsers}",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }),
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> user =
            List<Map<String, dynamic>>.from(response.data["users"]);

        // Take the most recent 3 statements

        return user;
      } else {
        throw Exception("Failed to fetch details");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data['message'] ?? e.message}");
    } catch (e) {
      throw Exception("Error fetching details: $e");
    }
  }
}
