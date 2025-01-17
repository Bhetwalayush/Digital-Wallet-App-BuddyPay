import 'package:buddypay_digital_wallet/core/common/snackbar/my_snackbar.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/login_usecase.dart';
import 'package:buddypay_digital_wallet/features/auth/presentation/viewmodels/bloc/signup/signup_bloc.dart';
import 'package:buddypay_digital_wallet/features/landing_page/cubit/landing_page_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../view/homepage_view.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignupBloc _signupBloc;
  final LandingPageCubit _landingpageCubit;
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required SignupBloc signupBloc,
    required LandingPageCubit landingpageCubit,
    required LoginUseCase loginUseCase,
  })  : _signupBloc = signupBloc,
        _landingpageCubit = landingpageCubit,
        _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    // Navigate to the Register screen
    on<NavigateRegisterScreenEvent>((event, emit) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _signupBloc),
            ],
            child: event.destination,
          ),
        ),
      );
    });

    // Navigate to the Home screen
    on<NavigateHomeScreenEvent>((event, emit) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: _landingpageCubit,
            child: event.destination,
          ),
        ),
      );
    });

    // Handle user login event
    on<LoginUserEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true)); // Set loading state
      final result = await _loginUseCase(
        LoginParams(
          phone: event.phone,
          password: event.password,
        ),
      );

      result.fold(
        (failure) {
          emit(state.copyWith(isLoading: false, isSuccess: false));
          showMySnackBar(
            context: event.context,
            message: "Invalid Credentials",
            color: Colors.red,
          );
        },
        (token) {
          emit(state.copyWith(isLoading: false, isSuccess: true));
          add(
            NavigateHomeScreenEvent(
              context: event.context,
              destination: const HomePage(),
            ),
          );
          // Example: Set the token in HomeCubit if needed
          // _homeCubit.setToken(token);
        },
      );
    });
  }
}
