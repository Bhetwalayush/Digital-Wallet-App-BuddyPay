part of 'signup_bloc.dart';

sealed class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class RegisterUser extends SignupEvent {
  final BuildContext context;
  final String fullname;
  final String phone;
  final String password;
  final String pin;
  final String device;

  const RegisterUser({
    required this.context,
    required this.fullname,
    required this.phone,
    required this.password,
    required this.pin,
    this.device = "mobile",
  });
}
