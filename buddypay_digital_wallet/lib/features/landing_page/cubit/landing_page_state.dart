import 'package:buddypay_digital_wallet/app/di/di.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/view/login_view.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/view/signup_view.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/login/login_bloc.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPageState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const LandingPageState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static LandingPageState initial() {
    return LandingPageState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<LoginBloc>(),
          child: LoginView(),
        ),
        BlocProvider(
          create: (context) => getIt<SignupBloc>(),
          child: const SignupView(),
        ),
        const Center(
          child: Text('Account'),
        ),
      ],
    );
  }

  LandingPageState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return LandingPageState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
