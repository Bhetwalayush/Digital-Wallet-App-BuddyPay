import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetChecker {
  // Create an instance of InternetConnectionChecker
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.createInstance();

  // Method to check if the device is connected to the internet
  Future<bool> isConnected() async {
    bool isConnected = await _connectionChecker.hasConnection;
    return isConnected;
  }
}
