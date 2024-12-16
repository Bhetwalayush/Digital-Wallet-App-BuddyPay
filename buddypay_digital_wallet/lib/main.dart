// import 'package:buddypay_digital_wallet/view/landing_page.dart';
import 'package:buddypay_digital_wallet/view/login_view.dart';
import 'package:buddypay_digital_wallet/view/onboarding_view.dart';
import 'package:buddypay_digital_wallet/view/signup_view.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BuddyPay',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingView(),
        '/login': (context) => const LoginView(),
        '/signup': (context) => const SignupView(),
      },
    );
  }
}
