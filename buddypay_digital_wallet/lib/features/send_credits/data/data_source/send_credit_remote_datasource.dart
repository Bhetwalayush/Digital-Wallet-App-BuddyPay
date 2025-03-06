import 'package:buddypay_digital_wallet/app/constants/api_endpoints.dart';
import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:buddypay_digital_wallet/features/send_credits/data/data_source/send_credit_datasourse.dart';
import 'package:dio/dio.dart';

// abstract class ISendCreditRemoteDataSource {
//   Future<String> sendCredit();
// }

class SendCreditRemoteDataSource implements ISendCreditRemoteDataSource {
  final Dio _dio;
  final UserSharedPrefs _userSharedPrefs;

  SendCreditRemoteDataSource(this._dio, this._userSharedPrefs);

  @override
  Future<String> sendCredit(String recipientNumber, double amount) async {
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
        ApiEndpoints.sendCredit,
        data: {
          "senderId": senderId,
          "recipientNumber": recipientNumber,
          "amount": amount,
        },
      );

      if (response.statusCode == 200) {
        Response response = await _dio.post(
          ApiEndpoints.createStatement,
          data: {
            "userId": senderId,
            "to": recipientNumber,
            "amount": amount,
            "statement": "Sent Rs $amount to $recipientNumber"
          },
        );
        return response.data["message"];
      } else {
        throw Exception("Failed to send credit: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data['message'] ?? e.message}");
    } catch (e) {
      throw Exception("Error sending credit: $e");
    }
  }
}
