import 'package:buddypay_digital_wallet/app/shared_prefs/user_shared_prefs.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/view/login_view.dart';
import 'package:buddypay_digital_wallet/features/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:buddypay_digital_wallet/features/on_boarding/view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(this._onboardingCubit) : super(null);

  final OnboardingCubit _onboardingCubit;
  late UserSharedPrefs userSharedPrefs;
  String? loadedPhone;

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    await _loadPhoneNumber(); // Load phone number before navigating

    if (context.mounted) {
      if (loadedPhone != null && loadedPhone!.isNotEmpty) {
        // Navigate to LoginView if phone exists
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      } else {
        // Navigate to OnboardingView otherwise
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _onboardingCubit,
              child: OnboardingView(),
            ),
          ),
        );
      }
    }
  }

  Future<void> _loadPhoneNumber() async {
    final prefs = await SharedPreferences.getInstance();
    userSharedPrefs = UserSharedPrefs(prefs);

    final result = await userSharedPrefs.getPhone();

    result.fold(
      (failure) => loadedPhone = null, // Handle failure (e.g., logging)
      (phone) => loadedPhone = phone, // Store phone if successful
    );
  }
}
