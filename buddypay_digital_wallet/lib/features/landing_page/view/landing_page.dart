import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFF00C9A7), // Background color
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    // App Icon
                    Image.asset(
                      'assets/icon/logo.png',
                      width: 100,
                    ),
                    const SizedBox(height: 20),
                    // App Title
                    const Text(
                      'BuddyPay',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // App Subtitle
                    const Text(
                      'All Your Finances Inside \n a Fancy App',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                // Buttons for Login and Signup
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const LoginView(),
                        //   ),
                        // );
                        context.read<LandingPageCubit>().openLoginView(context);
                      },
                      style: ElevatedButton.styleFrom(
                        // backgroundColor: Colors.white,
                        // foregroundColor: const Color(0xFF00C9A7),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('LOGIN'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const SignupView(),
                        //   ),
                        // );
                        context
                            .read<LandingPageCubit>()
                            .openSignupView(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color(0xFF00C9A7),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: const BorderSide(color: Colors.white),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('SIGN UP'),
                    ),
                  ],
                ),
                // Footer Design
                const Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Designed for you',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 5),
                    Icon(
                      Icons.favorite,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
