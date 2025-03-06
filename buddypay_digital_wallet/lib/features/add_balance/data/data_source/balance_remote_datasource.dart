import 'package:buddypay_digital_wallet/app/constants/api_endpoints.dart';
import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:buddypay_digital_wallet/features/add_balance/data/data_source/balance_datasourse.dart';
import 'package:dio/dio.dart';

class RechargeRemoteDataSource implements IRechargeRemoteDataSource {
  final Dio _dio;
  final UserSharedPrefs _userSharedPrefs;

  RechargeRemoteDataSource(this._dio, this._userSharedPrefs);

  @override
  Future<String> recharge(String code) async {
    try {
      final senderIdOrRight =
          await _userSharedPrefs.getUserId(); // Get Either<Failure, String>

      // Unwrap the senderId from the Right value
      final senderId = senderIdOrRight.fold(
        (failure) => '', // Handle the error case if the senderId is in Left
        (id) => id, // Extract the value if it is in Right
      );

      // if (senderId.isEmpty) {
      //   throw Exception("Sender ID is empty or invalid.");
      // }

      Response response = await _dio.post(
        ApiEndpoints.recharge,
        data: {
          "userId": senderId,
          "code": code,
        },
      );

      if (response.statusCode == 200) {
        // Log the full response data
        print('Recharge Response: ${response.data}');

        // Extract the amount from the first response
        String amount = response.data['amount'].toString();

        // Use a different name for the second response to avoid overwriting
        Response statementResponse = await _dio.post(
          ApiEndpoints.createStatement,
          data: {
            "userId": senderId,
            "to": "Self Recharge",
            "amount": amount,
            "statement": "Balance Recharge"
          },
        );

        // Optionally log the statement response
        print('Statement Response: ${statementResponse.data}');

        return response.data["message"];
      } else {
        throw Exception("Failed to recharge: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data['message'] ?? e.message}");
    } catch (e) {
      throw Exception("Error sending credit: $e");
    }
  }
}

Future<void> _saveUserData(Map<String, dynamic> userData) async {
  try {
    String token = userData['token'];
  } catch (e) {
    // Handle any errors that occur during user data processing
    throw Exception("Error saving user data: $e");
  }
}
