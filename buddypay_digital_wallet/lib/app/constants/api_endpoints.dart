class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api/";

  static const String login = "user/login";
  static const String register = "user/create";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "user/uploadImage";
}
