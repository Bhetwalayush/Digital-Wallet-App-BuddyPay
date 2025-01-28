import 'package:buddypay_digital_wallet/app/di/di.dart';
import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
import 'package:buddypay_digital_wallet/features/landing_page/view/landing_page.dart';
import 'package:buddypay_digital_wallet/features/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:buddypay_digital_wallet/features/on_boarding/view/onboarding_view.dart';
import 'package:buddypay_digital_wallet/features/splash/presentation/view/splash_view.dart';
import 'package:buddypay_digital_wallet/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  AppRoute._();

  // Define route names
  static const String splash_view = '/';
  static const String onboarding_view = '/onboarding';
  static const String landing_view = '/landingview';

  // Define a method to return the routes
  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      splash_view: (context) {
        return BlocProvider.value(
          value: getIt<SplashCubit>(),
          child: const SplashView(),
        );
      },
      onboarding_view: (context) {
        return BlocProvider<OnboardingCubit>(
          create: (_) =>
              getIt<OnboardingCubit>(), // Provide OnboardingCubit here
          child: OnboardingView(),
        );
      },
      landing_view: (context) {
        return BlocProvider<LandingPageCubit>(
          create: (_) =>
              getIt<LandingPageCubit>(), // Provide OnboardingCubit here
          child: const LandingPage(),
        );
      },
    };
  }
}
