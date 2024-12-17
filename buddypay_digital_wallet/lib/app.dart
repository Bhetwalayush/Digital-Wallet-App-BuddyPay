import 'package:buddypay_digital_wallet/core/app_theme/app_theme.dart';
import 'package:buddypay_digital_wallet/view/login_view.dart';
import 'package:buddypay_digital_wallet/view/onboarding_view.dart';
import 'package:buddypay_digital_wallet/view/signup_view.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BuddyPay',
      theme: getApplicationTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingView(),
        '/login': (context) => const LoginView(),
        '/signup': (context) => const SignupView(),
      },
    );
  }
}
