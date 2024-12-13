import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';
import '../models/signup_model.dart';

class ApiService {
  final String _baseUrl = 'http://localhost:5000'; // Replace with actual API URL

  // Login API
  Future<bool> login(User user) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Signup API
  Future<bool> signup(SignupModel signupModel) async {
    final url = Uri.parse('$_baseUrl/signup');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(signupModel.toJson()),
    );

    if (response.statusCode == 201) {
      return true; // User successfully saved
    } else {
      return false; // Failed to save user
    }
  }
}
