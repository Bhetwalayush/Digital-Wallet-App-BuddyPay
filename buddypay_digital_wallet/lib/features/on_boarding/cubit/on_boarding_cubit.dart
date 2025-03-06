import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
import 'package:buddypay_digital_wallet/features/on_boarding/cubit/on_boarding_state.dart';
import 'package:buddypay_digital_wallet/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(LandingPageCubit landingPageCubit)
      : super(OnboardingState.initial());

  // Update current page
  void updatePage(int index) {
    emit(state.copyWith(currentPage: index));
  }

  // Navigate to landing page
  void goToLandingPage(BuildContext context) {
    Navigator.pushNamed(context, AppRoute.landing_view);
  }
}
