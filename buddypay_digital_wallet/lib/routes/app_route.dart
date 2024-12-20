import 'package:buddypay_digital_wallet/view/onboarding_view.dart';

class AppRoute {
  AppRoute._();

  static String onboarding_view = '/';

  static getAppRoutes() {
    return {
      onboarding_view: (context) => const OnboardingView(),
    };
  }
}
