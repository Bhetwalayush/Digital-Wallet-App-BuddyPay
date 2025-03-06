import 'package:buddypay_digital_wallet/app/di/di.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/view/login_view.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/view/signup_view.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/login/login_bloc.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPageCubit extends Cubit<LandingPageState> {
  LandingPageCubit() : super(LandingPageState.initial());

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void openLoginView(BuildContext context) {
    // Wait for 2 seconds
    Future.delayed(const Duration(seconds: 1), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<LoginBloc>(),
              child: LoginView(),
            ),
          ),
        );
      }
    });
  }

  void openSignupView(BuildContext context) {
    // Wait for 2 seconds
    Future.delayed(const Duration(seconds: 1), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: getIt<SignupBloc>(),
              child: const SignupView(),
            ),
          ),
        );
      }
    });
  }
}
