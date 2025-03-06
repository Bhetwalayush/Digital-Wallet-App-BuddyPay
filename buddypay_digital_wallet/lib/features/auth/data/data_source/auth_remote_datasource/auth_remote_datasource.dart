import 'dart:convert';
import 'dart:io';

import 'package:buddypay_digital_wallet/app/constants/api_endpoints.dart';
import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:buddypay_digital_wallet/features/auth/data/data_source/auth_data_source.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/entity/auth_entity.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  @override
  Future<void> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiEndpoints.getUserData);

      // if (response.statusCode == 200) {
      //   // Assuming the API returns a JSON with name and balance
      //   String userName = response.data['userData']['fullname'];
      //   double userBalance = response.data['userData']['balance'];
      //   await UserSharedPrefs.saveUserData(
      //       userName,
      //       userBalance,
      //       response.data['userData']['id'],
      //       response.data['userData']['isAdmin']);

      //   // Save data to SharedPreferences
      //   // await UserSharedPrefs.saveUserData(userName, userBalance);
      // } else {
      //   throw Exception('Failed to load user data');
      // }
    } catch (e) {
      // Handle errors
      print('Error fetching user data: $e');
    }
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
        String token = response.data['token'];
        // Assuming the API returns a token upon successful login
        Map<String, dynamic> userData = response.data['userData'];

        // Store the token and user data using SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString(
            'userData', json.encode(userData)); // JSON encoding

        // Optionally, save user data using your own method (e.g., _saveUserData)
        // _saveUserData(userData);

        _saveUserData(response.data['userData']);

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

  Future<void> _saveUserData(Map<String, dynamic> userData) async {
    try {
      String token = userData['token'];
      String fullname = userData['fullname'];
      String phone = userData['phone'];
      int userBalance = int.tryParse(userData['balance'].toString()) ?? 0;
      String userId = userData['id'];
      String image = userData['image'];
      bool isAdmin = userData['isAdmin'];

      // Instantiate UserSharedPrefs using the SharedPreferences instance
      final sharedPreferences = await SharedPreferences.getInstance();
      final userSharedPrefs = UserSharedPrefs(sharedPreferences);

      // Save the user data using the instance method
      await userSharedPrefs.saveUserData(
          token, fullname, phone, userBalance, userId, image, isAdmin);
    } catch (e) {
      // Handle any errors that occur during user data processing
      throw Exception("Error saving user data: $e");
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
          'image': await MultipartFile.fromFile(
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
