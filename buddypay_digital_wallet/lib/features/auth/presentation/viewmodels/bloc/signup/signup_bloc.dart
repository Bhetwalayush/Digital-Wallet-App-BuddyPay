import 'package:bloc/bloc.dart';
import 'package:buddypay_digital_wallet/core/common/snackbar/my_snackbar.dart';
import 'package:buddypay_digital_wallet/features/auth/domain/use_case/signup_user_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final RegisterUseCase _registerUseCase;

  SignupBloc({
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        super(SignupState.initial()) {
    on<RegisterUser>(_onSignupEvent);
  }

  void _onSignupEvent(
    RegisterUser event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      fullname: event.fullname,
      phone: event.phone,
      password: event.password,
      pin: event.pin,
      device: event.device,
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }
}
