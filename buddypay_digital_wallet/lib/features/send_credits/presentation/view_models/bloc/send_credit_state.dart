part of 'send_credit_bloc.dart';

class SendCreditState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;

  const SendCreditState({
    required this.isLoading,
    required this.isSuccess,
    required this.errorMessage,
  });

  // Initial state
  factory SendCreditState.initial() {
    return const SendCreditState(
      isLoading: false,
      isSuccess: false,
      errorMessage: '',
    );
  }

  // Copy with method to return a new state with updated values
  SendCreditState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SendCreditState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [isLoading, isSuccess, errorMessage];
}
