import 'package:buddypay_digital_wallet/app.dart';
import 'package:buddypay_digital_wallet/app/di/di.dart';
import 'package:buddypay_digital_wallet/core/network/hive_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive Database
  await HiveService.init();

  await initDependencies();
  runApp(const MyApp());
}
