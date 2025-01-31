part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  const SignupState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
  });

  const SignupState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null;

  SignupState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
  }) {
    return SignupState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName];
}
