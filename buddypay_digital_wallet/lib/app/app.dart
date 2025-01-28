import 'package:buddypay_digital_wallet/core/app_theme/app_theme.dart';
import 'package:buddypay_digital_wallet/routes/app_route.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BuddyPay',
      theme: getApplicationTheme(),
      initialRoute: AppRoute.splash_view,
      routes: AppRoute.getAppRoutes(),
    );
  }
}
