import 'package:buddypay_digital_wallet/features/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:buddypay_digital_wallet/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<void> {
  SplashCubit(OnboardingCubit onboardingCubit) : super(null);

  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () {
      // Navigate directly to the Onboarding Screen
      if (context.mounted) {
        Navigator.pushNamed(context, AppRoute.onboarding_view);
      }
    });
  }
}
