import 'dart:io';

import 'package:buddypay_digital_wallet/app/constants/api_endpoints.dart';
import 'package:buddypay_digital_wallet/features/auth/data/data_source/auth_data_source.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String phone, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "phone": phone,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        // Assuming the API returns a token upon successful login
        String token = response.data['token'];
        return token;
      } else {
        throw Exception("Login failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      // Handle Dio-specific errors
      throw Exception("Dio error: ${e.response?.data['message'] ?? e.message}");
    } catch (e) {
      // Handle general errors
      throw Exception("Login error: $e");
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.register,
        data: {
          "fullname": user.fullname,
          "phone": user.phone,
          "password": user.password,
          "image": user.image,
          "pin": user.pin,
          "device": user.device,
        },
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
