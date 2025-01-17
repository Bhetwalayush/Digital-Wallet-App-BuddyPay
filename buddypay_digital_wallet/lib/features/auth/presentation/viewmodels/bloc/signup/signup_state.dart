part of 'signup_bloc.dart';

class SignupState {
  final bool isLoading;
  final bool isSuccess;

  SignupState({
    required this.isLoading,
    required this.isSuccess,
  });

  SignupState.initial()
      : isLoading = false,
        isSuccess = false;

  SignupState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
