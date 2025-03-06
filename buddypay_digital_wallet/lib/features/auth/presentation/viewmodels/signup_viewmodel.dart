import '../../../../services/api_service.dart';
import '../../data/models/signup_model.dart';

class SignupViewModel {
  final ApiService _apiService = ApiService();
  late SignupModel _signupModel;

  // Method to initialize the signup model
  void signup({
    required String fullName,
    required String phone,
    required String password,
  }) {
    _signupModel = SignupModel(
      fullName: fullName,
      phone: phone,
      password: password,
      pin: '', // PIN will be added later in the choose-pin screen
    );
  }

  // Method to set the PIN for the user
  void setPin(String pin) {
    _signupModel = SignupModel(
      fullName: _signupModel.fullName,
      phone: _signupModel.phone,
      password: _signupModel.password,
      pin: pin,
      device: _signupModel.device,
    );
  }

  // Method to save the user data to the database via the API
  Future<bool> saveUser() async {
    return await _apiService.signup(_signupModel);
  }
}
