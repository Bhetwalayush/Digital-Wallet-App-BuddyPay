class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3000/api/";
  static const String baseUrl = "http://192.168.101.6:3000/api/";

  static const String login = "user/login";
  static const String register = "user/create";
  static const String sendCredit = "user/sendcredit";
  // static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  // static const String imgUrl = "http://10.0.2.2:3000/public/uploads/";
  static const String imageUrl = "http://192.168.101.6:3000/uploads/";
  static const String uploadImage = "user/uploads";
  static const String getUserData = "user/senduserdetail";
  static const String getUsers = "user/";
  static const String createStatement = "statements/createStatement";
  static const String balance = "user/balance";
  static const String recharge = "recharge/validate";
  static const String fetchstatement = "statements/";
  // static const String fingerprint = "user/update-fingerprint/$userId";
}
