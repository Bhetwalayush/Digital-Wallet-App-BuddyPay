import 'package:buddypay_digital_wallet/app/di/di.dart';
import 'package:buddypay_digital_wallet/features/landing_page/view/landing_page.dart';
import 'package:buddypay_digital_wallet/features/on_boarding/view/onboarding_view.dart';
import 'package:buddypay_digital_wallet/features/splash/presentation/view/splash_view.dart';
import 'package:buddypay_digital_wallet/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoute {
  AppRoute._();

  static String splash_view = '/';
  static String onboarding_view = '/onboardingview';
  static const String landing_view = '/landingview';

  static getAppRoutes() {
    return {
      splash_view: (context) {
        return BlocProvider.value(
          value: getIt<SplashCubit>(),
          child: const SplashView(),
        );
      },
      onboarding_view: (context) => OnboardingView(),
      landing_view: (context) => const LandingPage(),
    };
  }
}
