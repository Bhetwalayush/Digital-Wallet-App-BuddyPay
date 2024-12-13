import 'package:flutter/material.dart';
import '../models/login_model.dart';
import '../services/api_service.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool isSavingInfo = false;

  Future<bool> login(String phone, String password) async {
    // Validate inputs
    if (phone.isEmpty || password.isEmpty) {
      return false;
    }

    try {
      User user = User(phone: phone, password: password);
      return await _apiService.login(user);
    } catch (e) {
      // Handle any errors that may occur
      return false;
    }
  }

  void toggleSaveInfo(bool value) {
    isSavingInfo = value;
    notifyListeners();
  }
}
